resource "aws_internet_gateway" "primary" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${local.prefix}-primary-ig"
  }
}