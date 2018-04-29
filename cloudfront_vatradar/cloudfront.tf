/*
  Define CloudFront Origin Access Identity
*/
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "access-identity-static-source-vatradar-com.s3.amazonaws.com"
}

/*
  Define CloudFront Distribution
  Alias: www.ndavies.io, ndavies.io
*/
resource "aws_cloudfront_distribution" "cf_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.source.bucket_domain_name}"
    origin_id   = "static-source-vatradar-com"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "vatradar.com Static Frontend Distribution"
  default_root_object = "index.html"

  aliases = ["vatradar.com"]

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "static-source-vatradar-com"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 60
    max_ttl                = 60
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
