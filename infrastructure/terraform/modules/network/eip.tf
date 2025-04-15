resource "aws_eip" "nat" {
  for_each = local.public_subnets
  
  vpc = true
  
  tags = {
    Name = "${local.prefix}-eip-${each.key}"
  }
}