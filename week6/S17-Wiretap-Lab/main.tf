provider "aws" {
  region = "us-east-1"
}

# 1. The Target Network (Pre-built to save time)
resource "aws_vpc" "target_vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "TKH-Target-VPC"
  }
}

# 2. The IAM Role for Flow Logs (Provided to reduce IAM friction)
resource "aws_iam_role" "flow_log_role" {
  name = "TKH-Flow-Log-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "vpc-flow-logs.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "flow_log_policy" {
  name = "TKH-Flow-Log-Policy"
  role = aws_iam_role.flow_log_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ]
      Effect   = "Allow"
      Resource = "*"
    }]
  })
}

# --- STUDENTS WILL ADD THEIR FLOW LOG AND CLOUDWATCH RESOURCES BELOW ---
resource "aws_cloudwatch_log_group" "vpc_logs" {
  name              = "/tkh/vpc-flow-logs"
  retention_in_days = 1 # Keep costs at absolute zero
}

resource "aws_flow_log" "main_wiretap" {
  iam_role_arn    = aws_iam_role.flow_log_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_logs.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.target_vpc.id
}