resource "aws_cloudwatch_log_group" "ecs" {
  name              = "${var.system_name}/${var.system_env}/ecs"
  retention_in_days = 7
}
