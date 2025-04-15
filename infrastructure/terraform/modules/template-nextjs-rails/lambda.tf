/* resource "aws_lambda_function" "basic_auth" {
  filename         = "lambda_basic_auth.zip"
  function_name    = "${var.system_name}-basic-auth"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  publish          = true
  source_code_hash = filebase64sha256("lambda_basic_auth.zip")

  environment {
    variables = {
      AUTH_USER = var.basic_auth_user
      AUTH_PASS = var.basic_auth_password
    }
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.system_name}-lambda-exec"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_basic_exec" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lb_listener_rule" "auth_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 1

  action {
    type = "authenticate-cognito"
    authenticate_cognito {
      user_pool_arn       = aws_cognito_user_pool.pool.arn
      user_pool_client_id = aws_cognito_user_pool_client.client.id
      user_pool_domain    = aws_cognito_user_pool_domain.domain.domain
      session_cookie_name = "AWSELBAuthSessionCookie"
    }
  }

  condition {
    host_header {
      values = [var.system_domain]
    }
  }
}

resource "aws_cognito_user_pool" "pool" {
  name = "${var.system_name}-user-pool"
}

resource "aws_cognito_user_pool_client" "client" {
  name         = "${var.system_name}-client"
  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_user_pool_domain" "domain" {
  domain       = "${var.system_name}-domain"
  user_pool_id = aws_cognito_user_pool.pool.id
}
 */