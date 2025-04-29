/* #
# 平日18:00 にRDSを停止するLambda Functionをキックするスケジューラ
#
resource "aws_cloudwatch_event_rule" "stop_rds_weekdays_18" {
  name                = "stop_rds_weekdays_18"
  description         = "Stop RDS on weekdays at 18:00"
  schedule_expression = "cron(0 9 ? * MON-FRI *)"  # Adjusted to UTC+0 for JST
}

resource "aws_cloudwatch_event_target" "stop_rds_weekdays_18_target" {
  rule      = aws_cloudwatch_event_rule.stop_rds_weekdays_18.name
  target_id = "lambda_stop_rds_weekdays_18"
  arn       = aws_lambda_function.stop_rds.arn
}

resource "aws_lambda_permission" "allow_eventbridge_to_invoke_stop_rds_weekdays_18" {
  statement_id  = "AllowExecutionFromEventBridge_stop_rds_weekdays_18"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stop_rds.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_rds_weekdays_18.arn
}

#
# 土日にRDSを停止するLambda Functionをキックするスケジューラ
#
resource "aws_cloudwatch_event_rule" "stop_rds_weekends" {
  name                = "stop_rds_weekends"
  description         = "Stop RDS on weekends"
  schedule_expression = "cron(0 15 ? * SUN,SAT *)"  # Adjusted to UTC+0 for JST
}

resource "aws_cloudwatch_event_target" "stop_rds_weekends_target" {
  rule      = aws_cloudwatch_event_rule.stop_rds_weekends.name
  target_id = "lambda_stop_rds_weekends"
  arn       = aws_lambda_function.stop_rds.arn
}

resource "aws_lambda_permission" "allow_eventbridge_to_invoke_stop_rds_weekends" {
  statement_id  = "AllowExecutionFromEventBridge_stop_rds_weekends"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stop_rds.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_rds_weekends.arn
}
 */