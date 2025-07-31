terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.3.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-state-deepesh"
    key            = "global/terraform.tfstate"
    region         = "ap-south-1"
    # use_lockfile   = true  # Enables locking using the default method
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

resource "aws_s3_bucket" "test" { 
  bucket = "my-test-bucket-${random_id.bucket_suffix.hex}" 
} 
 
resource "random_id" "bucket_suffix" { 
  byte_length = 4 
} 