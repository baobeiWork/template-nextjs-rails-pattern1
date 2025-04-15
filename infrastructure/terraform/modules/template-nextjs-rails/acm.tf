# ==========================
# Frontend
# ==========================
resource "aws_acm_certificate" "frontend_cert" {
  provider = aws.us_east_1
  domain_name       = var.system_domain
  validation_method = "DNS"
  
  tags = {
    Name = "${var.system_domain}-frontend-cert"
  }
}

resource "aws_acm_certificate_validation" "frontend_cert_validation" {
  provider = aws.us_east_1
  certificate_arn = aws_acm_certificate.frontend_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.frontend_cert_validation : record.fqdn]
}

# ==========================
# Backend 
# ==========================
resource "aws_acm_certificate" "backend_cert" {
  domain_name       = "backend.${var.system_domain}"
  validation_method = "DNS"
  
  tags = {
    Name = "${var.system_domain}-backend-cert"
  }
}

resource "aws_acm_certificate_validation" "backend_cert_validation" {
  certificate_arn = aws_acm_certificate.backend_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.backend_cert_validation : record.fqdn]
}
