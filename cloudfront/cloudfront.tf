/*
  Define CloudFront Distribution
  Alias: www.ndavies.io, ndavies.io
*/
resource "aws_cloudfront_distribution" "cf_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.source.bucket_domain_name}"
    origin_id   = "static-source-ndavies-io"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "ndavies.io Static Frontend Distribution"
  default_root_object = "index.html"

  aliases = ["www.ndavies.io", "ndavies.io"]

  default_cache_behavior {
    allowed_methods   = ["GET", "HEAD", "OPTIONS"]
    cached_methods    = ["GET", "HEAD"]
    target_origin_id  = "static-source-ndavies-io"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 60
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags {
    Environment = "Production"
    Owner       = "${var.owner}"
  }

  viewer_certificate {
    acm_certificate_arn      = "${data.aws_acm_certificate.cert.arn}"
    minimum_protocol_version = "TLSv1"
    ssl_support_method       = "sni-only"
  }
}
