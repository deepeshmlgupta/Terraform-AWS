resource "aws_s3_bucket" "my_bucket" {
  bucket = "deepesh-demo-bucket-12345"

  tags = {
    Name        = "MyDemoBucket"
    Environment = "Develop"
  }
}