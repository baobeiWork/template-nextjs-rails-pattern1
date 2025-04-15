resource "aws_ecs_service" "main" {
  name            = "${local.prefix}-service"
  cluster         = aws_ecs_cluster.main.name
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = var.ecs_task_backend_desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [
      aws_security_group.backend_ecs.id
    ]
  }

  health_check_grace_period_seconds = 40

  load_balancer {
    target_group_arn = aws_lb_target_group.backend.arn
    container_name   = "backend"
    container_port   = var.ecs_task_backend_container_port
  }

  depends_on = [
    aws_lb_target_group.backend,
    aws_lb_listener.backend_http
  ]
}
