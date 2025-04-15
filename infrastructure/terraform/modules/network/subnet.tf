resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  map_public_ip_on_launch = true
  availability_zone = element(local.default_az, index(keys(local.public_subnets), each.key))

  tags = {
    Name = "${local.prefix}-public-${each.key}"
  }
}

resource "aws_subnet" "private" {
  for_each = local.private_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  map_public_ip_on_launch = true
  availability_zone = element(local.default_az, index(keys(local.private_subnets), each.key))

  tags = {
    Name = "${local.prefix}-private-${each.key}"
  }
}
