# =========================================================================
# PROVIDER & DATA SOURCES
# =========================================================================
provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# =========================================================================
# STEP 2: FINTECH FINANCIAL FIREWALL (AWS BUDGET)
# =========================================================================
resource "aws_budgets_budget" "budget" {
  name              = "titan-fintech-monthly-budget"
  budget_type       = "COST"
  limit_amount      = "10" # Hard limit of $10.00 USD
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2026-07-01_00:00" # Active for July 2026

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80 # 80% Threshold ($8.00)
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["oscarestj@gmail.com"] # Students put their address here
  }
}

# =========================================================================
# STEP 3: SECURE S3 VAULT
# =========================================================================
resource "random_id" "id" {
  byte_length = 4
}

resource "aws_s3_bucket" "vault" {
  bucket        = "titan-fintech-vault-oe-${random_id.id.hex}" # Students replace "yourinitials"
  force_destroy = true # Mandatory for seamless budget teardowns
}

# Block all public access to keep the vault strictly private
resource "aws_s3_bucket_public_access_block" "vault_privacy" {
  bucket                  = aws_s3_bucket.vault.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# =========================================================================
# STEP 4: SURGICAL IAM ROLE & POLICY (PRINCIPLE OF LEAST PRIVILEGE)
# =========================================================================
# Trust Policy allowing EC2 to assume this role
resource "aws_iam_role" "vault_role" {
  name = "Titan-EC2-Vault-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Policy allowing ONLY PutObject (Write-Only) to the S3 bucket
resource "aws_iam_policy" "vault_policy" {
  name        = "Titan-S3-PutObject-Only"
  description = "Allows write-only object permissions to the secure S3 vault"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject"
        ]
        # SECURE INTERPOLATION: Scoped strictly to the bucket contents
        Resource = [
          "${aws_s3_bucket.vault.arn}/*"
        ]
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "vault_attach" {
  role       = aws_iam_role.vault_role.name
  policy_arn = aws_iam_policy.vault_policy.arn
}

# =========================================================================
# STEP 5: COMPUTE INSTANCE & INSTANCE PROFILE
# =========================================================================
# Create the IAM Instance Profile so the EC2 instance can "wear" the role
resource "aws_iam_instance_profile" "vault_profile" {
  name = "Titan-EC2-Vault-Profile"
  role = aws_iam_role.vault_role.name
}

resource "aws_instance" "vault_target" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.vault_profile.name

  tags = {
    Name = "Titan-Secure-Vault-Compute"
  }
}