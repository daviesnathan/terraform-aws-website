/*
  CloudFront ALIAS Record
  ndavies.io
*/
resource "aws_route53_record" "root_web" {
  zone_id = "${var.dns_zone}"
  name    = "vatradar.com"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.cf_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.cf_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}
