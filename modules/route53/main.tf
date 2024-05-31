
resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "hello_cert_dns" {
  allow_overwrite = true
  name = var.resource_record_name
  records =  [for val in var.resource_record_value: val]
  type = var.resource_record_type
  zone_id = aws_route53_zone.main.zone_id
  ttl = 60
}

resource "aws_acm_certificate_validation" "hello_cert_validate" {
  certificate_arn = var.certificate_arn
  validation_record_fqdns = [aws_route53_record.hello_cert_dns.fqdn]
}

resource "aws_route53_record" "cloudfront_alias" {
  zone_id = aws_route53_zone.main.id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = true
  }
}
