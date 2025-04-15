locals {
  prefix = "${var.system_name}-${var.system_env}"
  default_az = [
    "ap-northeast-1a",
    "ap-northeast-1c"
  ]
  public_subnets = {
    subnet1 = cidrsubnet(var.vpc_cidr, 8, 11),
    subnet2 = cidrsubnet(var.vpc_cidr, 8, 12),
  }
  private_subnets = {
    subnet1 = cidrsubnet(var.vpc_cidr, 8, 21),
    subnet2 = cidrsubnet(var.vpc_cidr, 8, 22),
  }
}