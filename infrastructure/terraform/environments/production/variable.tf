# ==========================
# AWS
# ==========================
variable "AWS_ACCESS_KEY" {
  description = "AWS access key"
}

variable "AWS_SECRET_KEY" {
  description = "AWS secret key"
}

# ==========================
# System
# ==========================
variable "SYSTEM_NAME" {
  description = "Name of the system"
}

variable "SYSTEM_ENV" {
  description = "Environment of the system"
}

variable "SYSTEM_AZ" {
  description = "Availability Zone of the system"
}

variable "SYSTEM_REGION" {
  description = "Region of the system"
}
