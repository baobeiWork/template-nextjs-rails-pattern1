# ================
# Route Table 
# ================
resource "aws_route_table" "public" {
  for_each = local.public_subnets

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.prefix}-public-rt-${each.key}"
  }
}

resource "aws_route_table" "private" {
  for_each = local.private_subnets

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.prefix}-private-rt-${each.key}"
  }
}

# ================
# Route 
# ================
resource "aws_route" "public_internet_access" {
  for_each = aws_route_table.public

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.primary.id
}

resource "aws_route" "private_nat_gateway" {
  for_each = aws_nat_gateway.main

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = each.value.id
}

# ================
# Route Associations
# ================
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public[each.key].id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}

