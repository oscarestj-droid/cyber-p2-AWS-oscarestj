provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "state_bucket" {
  bucket        = "tkh-state-bucket-oe"
  force_destroy = true
}

resource "aws_dynamodb_table" "state_locks" {
  name         = "tkh-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

#terraform {
#  backend "s3" {
#    bucket         = "tkh-state-bucket-oe"
#    key            = "global/s3/terraform.tfstate"
#    region         = "us-east-1"
#    dynamodb_table = "tkh-state-locks"
#  }
#}

resource "aws_instance" "state_target" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t3.micro"

  tags = {
    Name = "TKH-State-Tracking-Target"
  }
}