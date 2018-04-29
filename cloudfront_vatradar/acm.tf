/*
  provider alias: useast
  Note: Due to CloudFront requiring ACM certs to be generated within us-east-1,
        it is necessary to call the data block to fetch the cert's ARN using
        an additional aws provider set specifically to that region.
*/
provider "aws" {
  alias  = "useast"
  region = "us-east-1"
}

/*
  Retrive the ARN for the ACM certs (*.ndavies.io)
*/
data "aws_acm_certificate" "cert" {
  provider = "aws.useast"

  domain   = "*.vatradar.com"
  statuses = ["ISSUED"]
}
