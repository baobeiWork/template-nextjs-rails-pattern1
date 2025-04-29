# =========================
# VPC network
# =========================
module "network" {
  source = "../../modules/network/"

  # System
  system_name = var.SYSTEM_NAME
  system_env  = var.SYSTEM_ENV

  # Network
  vpc_cidr    = "10.10.0.0/16"
}

# =========================
# Main
# =========================
module "main-components" {
  source = "../../modules/template-nextjs-rails/"

  providers = {
    aws = aws
    aws.us_east_1 = aws.us_east_1
  }

  # System
  system_name   = var.SYSTEM_NAME
  system_env    = var.SYSTEM_ENV
  system_domain = var.SYSTEM_DOMAIN

  # Network
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids

  # ECS
  ecs_task_backend_cpu            = 256
  ecs_task_backend_memory         = 512
  ecs_task_backend_container_port = 3000
  ecs_task_backend_desired_count  = 1
  ecs_access_allowed_ip           = [
  ]

  # RDS
  rds_instance_class  = "db.m5d.large" 
  rds_enable_multi_az = false     
  
  depends_on = [
    module.network
  ]
}
