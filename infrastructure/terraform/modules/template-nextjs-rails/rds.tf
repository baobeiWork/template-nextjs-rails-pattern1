resource "aws_db_instance" "main" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.36"
  instance_class       = var.rds_instance_class
  db_subnet_group_name = aws_db_subnet_group.main.name
  username             = data.aws_ssm_parameter.db_username.value
  password             = data.aws_ssm_parameter.db_password.value
  parameter_group_name = "default.mysql8.0"
  multi_az             = var.rds_enable_multi_az
  publicly_accessible  = true
  skip_final_snapshot  = true
  identifier           = "${local.prefix}-main-rds"
  vpc_security_group_ids = [aws_security_group.rds.id]

  tags = {
    Name = "${local.prefix}-main-rds"
  }

  depends_on = [
    aws_db_subnet_group.main
  ]
}

resource "aws_db_subnet_group" "main" {
  name       = "${local.prefix}-main-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${local.prefix}-main-db-subnet-group"
  }
}
