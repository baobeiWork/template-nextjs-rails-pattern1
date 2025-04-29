resource "aws_sesv2_email_identity" "main" {
  email_identity         = var.system_domain
  configuration_set_name = aws_sesv2_configuration_set.main.configuration_set_name
}

resource "aws_sesv2_configuration_set" "main" {
  configuration_set_name = "${var.system_name}-ses-config-set"
  suppression_options {
    suppressed_reasons = ["BOUNCE", "COMPLAINT"]
  }
}