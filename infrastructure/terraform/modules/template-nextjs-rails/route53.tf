# ==========================
# Frontend ACM 
# ==========================
resource "aws_route53_record" "frontend_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.frontend_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 300
}

# ==========================
# Backend ACM 
# ==========================
resource "aws_route53_record" "backend_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.backend_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 300
}

# ==========================
# Frontend 
# ==========================
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.system_domain
  type    = "A"
  
  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

# ==========================
# Backend 
# ==========================
resource "aws_route53_record" "backend" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "backend.${var.system_domain}"
  type    = "A"
  
  alias {
    name                   = aws_lb.backend.dns_name
    zone_id                = aws_lb.backend.zone_id
    evaluate_target_health = false
  }
}

# ==========================
# SES
# ==========================
resource "aws_route53_record" "dkim" {
  count   = 3
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${element(aws_sesv2_email_identity.main.dkim_signing_attributes[0].tokens, count.index)}._domainkey.${var.system_domain}"
  type    = "CNAME"
  ttl     = 1800
  records = ["${element(aws_sesv2_email_identity.main.dkim_signing_attributes[0].tokens, count.index)}.dkim.amazonses.com"]
}