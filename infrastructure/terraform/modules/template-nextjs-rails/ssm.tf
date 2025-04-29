#resource "aws_ssm_parameter" "ecrRepoURL" {
#  name  = data.aws_ssm_parameter.ecrRepoURL.name
#  type  = "String"
#  value = aws_ecr_repository.main.repository_url
#  overwrite = true
#
#  depends_on = [
#    data.aws_ecr_repository.main
#  ]
#}

resource "aws_ssm_parameter" "db_host" {
  name  = data.aws_ssm_parameter.db_host.name
  type  = "String"
  value = aws_db_instance.main.address
  overwrite = true

  depends_on = [
    aws_db_instance.main
  ]
}