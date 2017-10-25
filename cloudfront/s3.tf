/*
  Create S3 Bucket to act as the data origin for the CloudFront Distribution
*/
resource "aws_s3_bucket" "source" {
  bucket = "static-source-ndavies-io"
  acl    = "private"

  tags {
    Name        = "static-source-ndavies.io"
    Environment = "Production"
    Owner       = "${var.owner}"
  }
}
