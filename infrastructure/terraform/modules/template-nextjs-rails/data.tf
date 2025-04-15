data "aws_route53_zone" "main" {
  name = var.system_domain
}

data "aws_ssm_parameter" "ecrRepoURL" {
  name = "/{}/production/ecrRepoURL"
}

# ==========================
# ECR
# ==========================
data "aws_ecr_repository" "backend_repo" {
  name = "${local.prefix}-main-repo"
}

# ==========================
# RDS
# ==========================
data "aws_ssm_parameter" "db_host" {
  name = "/asset-compass/production/db_host"
}
data "aws_ssm_parameter" "db_username" {
  name = "/asset-compass/production/db_user"
}
data "aws_ssm_parameter" "db_password" {
  name = "/asset-compass/production/db_password"
}
/* data "aws_ssm_parameter" "db_name" {
  name = "/asset-compass/production/db_password"
} */
