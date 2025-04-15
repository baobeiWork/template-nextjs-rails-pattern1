/* resource "null_resource" "rds_start" {
  provisioner "local-exec" {
    command = <<EOT
      zip ${local.lambda_dir}/zip/rds/start.zip ${local.lambda_dir}/src/rds/start.js
    EOT
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "aws_lambda_function" "start_rds" {
  filename         = "${local.lambda_dir}/zip/rds/start.zip"
  function_name    = "StartRDSInstance"
  role             = aws_iam_role.lambda_role.arn
  handler          = "start_rds.handler"
  runtime          = "nodejs20.x"
  #source_code_hash = filebase64sha256("${local.lambda_dir}/zip/rds/start.zip")

  environment {
    variables = {
      SYSTEM_NAME = var.system_name
      SYSTEM_ENV  = var.system_env
    }
  }

  depends_on = [
    null_resource.rds_start,
    aws_iam_role_policy.lambda_policy
  ]
}
 */