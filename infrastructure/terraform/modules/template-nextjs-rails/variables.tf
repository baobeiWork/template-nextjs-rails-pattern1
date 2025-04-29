# ==========================
# System
# ==========================
variable system_name {
  type        = string
}
variable system_env {
  type        = string
}
variable system_domain {
  type        = string
}

# ==========================
# Network
# ==========================
variable vpc_id {
  type = string
}
variable public_subnet_ids {
  type = list
}
variable  private_subnet_ids {
  type = list
}

# ==========================
# IAM
# ==========================
#variable operation_users {
#  type = list
#}


# ==========================
# ECS
# ==========================
variable ecs_task_backend_cpu {
  type        = number
  description = "ECF backend task cpu"
}
variable ecs_task_backend_memory {
  type        = number
  description = "ECF backend task memory"
}
variable ecs_task_backend_container_port {
  type        = number
  description = "ECF backend task port"
}
variable ecs_task_backend_desired_count {
  type        = number
  description = "description"
}
variable ecs_access_allowed_ip {
  type        = list
  description = "define CIDR IP"
}



# ==========================
# RDS
# ==========================
variable rds_instance_class {
  type        = string
  description = "RDS Instance class / type"
}

variable rds_enable_multi_az {
  type        = bool
  description = "Switch multi az / single az"
}

