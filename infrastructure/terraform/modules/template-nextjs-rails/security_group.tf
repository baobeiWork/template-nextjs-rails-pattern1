# ==========================
# Backend ALB
# ==========================
resource "aws_security_group" "backend_alb" {
  name        = "${local.prefix}-backend-alb-sg"
  description = "Security group for Backend ALB"
  vpc_id      = var.vpc_id

  # Allow HTTP and HTTPS traffic from specific IPs and S3
  ## Now . only specific S3
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ecs_access_allowed_ip
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.ecs_access_allowed_ip
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.prefix}-backend-alb-sg"
  }
}


# ==========================
# Backend ECS
# ==========================
resource "aws_security_group" "backend_ecs" {
  name        = "${local.prefix}-backend-ecs-sg"
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id

  # Allow traffic from Backend ALB
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    security_groups = [aws_security_group.backend_alb.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.prefix}-backend-ecs-sg"
  }
}


# ==========================
# RDS Security Group
# ==========================
resource "aws_security_group" "rds" {
  name        = "${local.prefix}-rds-sg"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  # Allow incoming connections from ECS tasks
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.backend_ecs.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.prefix}-rds-sg"
  }
}

