resource "aws_nat_gateway" "main" {
  for_each = local.public_subnets

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = {
    Name = "${local.prefix}-nat-gw-${each.key}"
  }

  depends_on = [aws_internet_gateway.primary]
}
