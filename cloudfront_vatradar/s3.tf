/*
  Define S3 Policy
  This policy grants read only access to the cloudfront_access_identity.
*/
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::static-source-vatradar-com/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::static-source-vatradar-com"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }
}

/*
  Create S3 Bucket to act as the data origin for the CloudFront Distribution
*/
resource "aws_s3_bucket" "source" {
  bucket = "static-source-vatradar-com"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.s3_policy.json}"

  tags {
    Name        = "static-source-vatradar.com"
    Environment = "Production"
    Owner       = "${var.owner}"
  }
}
