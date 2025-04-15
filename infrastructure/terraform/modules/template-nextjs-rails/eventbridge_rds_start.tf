/* #
# 平日10:00 にRDSを起動Lambda Functionをキックするスケジューラ
#
resource "aws_cloudwatch_event_rule" "start_rds_weekdays_10" {
  name                = "start_rds_weekdays_10"
  description         = "Start RDS on weekdays at 10:00"
  schedule_expression = "cron(0 1 ? * MON-FRI *)"  # Adjusted to UTC+0 for JST
}

resource "aws_cloudwatch_event_target" "start_rds_weekdays_10_target" {
  rule      = aws_cloudwatch_event_rule.start_rds_weekdays_10.name
  target_id = "lambda_start_rds_weekdays_10"
  arn       = aws_lambda_function.start_rds.arn
}

resource "aws_lambda_permission" "allow_eventbridge_to_invoke_start_rds_weekdays_10" {
  statement_id  = "AllowExecutionFromEventBridge_start_rds_weekdays_10"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.start_rds.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.start_rds_weekdays_10.arn
}
 */