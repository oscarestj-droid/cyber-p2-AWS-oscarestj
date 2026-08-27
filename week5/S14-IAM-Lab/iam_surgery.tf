
provider "aws" {
  region = "us-east-1"
}

provider "random" {}

# ==========================================
# 👤 THE IAM USER & POLICY ATTACHMENT
# ==========================================
resource "aws_iam_user" "dave" {
  name = "Dave_The_Dev"
}

resource "aws_iam_user_policy_attachment" "dave_attachment" {
  user       = aws_iam_user.dave.name
  policy_arn = aws_iam_policy.dev_policy.arn
}

# ==========================================
# 🔒 LEAST-PRIVILEGE IAM POLICY
# ==========================================
resource "aws_iam_policy" "dev_policy" {
  name        = "Dangerous_Wildcard_Policy"
  description = "Remediated developer policy scoped to finance data access"

  # REMEDIATION: Eradicated broad wildcards (*). Scoped actions tightly to finance S3 targets.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = [
          aws_s3_bucket.finance_data.arn,
          "${aws_s3_bucket.finance_data.arn}/*"
        ]
      }
    ]
  })
}

# ==========================================
# 🪣 TARGET SECURE STORAGE INFRASTRUCTURE
# ==========================================
resource "aws_s3_bucket" "finance_data" {
  bucket        = "tkh-finance-data-secured-bucket-${random_id.bucket_suffix.hex}"
  force_destroy = true # Mandatory for clean teardown to protect student budgets
}

# Fixed to use the standard "random" provider resource type instead of "aws_random_id"
resource "random_id" "bucket_suffix" {
  byte_length = 4
}