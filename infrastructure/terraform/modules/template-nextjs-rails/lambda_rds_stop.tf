/* resource "null_resource" "rds_stop" {
  provisioner "local-exec" {
    command = <<EOT
      zip ${local.lambda_dir}/zip/rds/stop.zip ${local.lambda_dir}/src/rds/stop.js
    EOT
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "aws_lambda_function" "stop_rds" {
  filename         = "${local.lambda_dir}/zip/rds/stop.zip"
  function_name    = "StopRDSInstance"
  role             = aws_iam_role.lambda_role.arn
  handler          = "stop_rds.handler"
  runtime          = "nodejs20.x"
  #source_code_hash = filebase64sha256("${local.lambda_dir}/zip/rds/stop.zip")

  environment {
    variables = {
      SYSTEM_NAME = var.system_name
      SYSTEM_ENV  = var.system_env
    }
  }

  depends_on = [
    null_resource.rds_stop,
    aws_iam_role_policy.lambda_policy
  ]
} */