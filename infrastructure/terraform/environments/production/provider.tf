terraform {
  required_version = ">= 1.0.0"
  backend "s3" {}
}

provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region     = var.SYSTEM_REGION
  default_tags {
    tags = {
      Env    = "${terraform.workspace}"
      System = var.SYSTEM_NAME
    }
  }
}

# For Cloud front
provider "aws" {
  alias  = "us_east_1"
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region = "us-east-1"
  default_tags {
    tags = {
      Env    = "${terraform.workspace}"
      System = var.SYSTEM_NAME
    }
  }
}
