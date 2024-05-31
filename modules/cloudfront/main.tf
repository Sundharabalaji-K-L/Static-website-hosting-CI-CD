resource "aws_cloudfront_origin_access_control" "cloudfront_s3_oac" {
  name                              = var.oac_name
  description                       = var.oac_desc
  origin_access_control_origin_type = var.type
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

locals {
  key_list = keys(var.origins)
}

resource "aws_cloudfront_distribution" "s3_distribution" {

   origin_group {
    origin_id = "groupS3"

    failover_criteria {
      status_codes = [403, 404, 500, 502]
    }

    dynamic "member" {
      for_each = var.origins
      content {
        origin_id = member.key
      }
    }
  }
  dynamic "origin" {
    for_each = var.origins

    content {
      domain_name              = origin.value.domain_name
      origin_access_control_id = aws_cloudfront_origin_access_control.cloudfront_s3_oac.id
      origin_id                = origin.key
    }
  }
  
  

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"
  aliases = var.aliases

default_cache_behavior {
  cache_policy_id           = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  allowed_methods           = ["GET", "HEAD", "OPTIONS"]
  cached_methods            = ["GET", "HEAD"]
  target_origin_id          = "groupS3" 
  viewer_protocol_policy    = "redirect-to-https"
  min_ttl                   = 0
  default_ttl               = 3600
  max_ttl                   = 86400
  compress                  = true
}


  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "IN"]
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    //acm_certificate_arn = var.certificate_arn
    cloudfront_default_certificate = true
  }
}
