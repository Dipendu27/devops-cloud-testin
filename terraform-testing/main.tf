# 1. Define the Cloud Provider
provider "aws" {
  region = "ap-south-1" # Mumbai Region
}

# 2. Define the Resource (An S3 Bucket)
resource "aws_s3_bucket" "qa_automation_logs" {
  bucket = "dipendu-terraform-automated-logs"

  tags = {
    Environment = "QA"
    ManagedBy   = "Terraform"
  }
}
