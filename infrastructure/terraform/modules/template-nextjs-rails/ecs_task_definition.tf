resource "aws_ecs_task_definition" "backend" {
  family                   = "${local.prefix}-backend-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_task_backend_cpu
  memory                   = var.ecs_task_backend_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  runtime_platform {
    cpu_architecture = "ARM64"
    operating_system_family = "LINUX"
  }
  container_definitions    = templatefile("${local.task_dir}/backend.json", { 
    image                  = "${data.aws_ecr_repository.backend_repo.repository_url}:latest",
    cpu                    = var.ecs_task_backend_cpu,
    memory                 = var.ecs_task_backend_memory,
    awslogs_group          = "${var.system_name}/${var.system_env}/ecs",
    container_port         = var.ecs_task_backend_container_port,
    rails_env              = var.system_env,
    system_domain          = var.system_domain,
    database_host          = data.aws_ssm_parameter.db_host.value,
    database_name          = data.aws_ssm_parameter.db_name,
    database_user          = data.aws_ssm_parameter.db_username.value,
    database_password      = data.aws_ssm_parameter.db_password.value
  })
}

