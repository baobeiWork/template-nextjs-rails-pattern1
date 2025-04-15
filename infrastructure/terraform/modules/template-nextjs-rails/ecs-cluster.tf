resource "aws_ecs_cluster" "main" {
  name = "${local.prefix}-main-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}