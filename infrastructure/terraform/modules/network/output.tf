output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [ for k, v in aws_subnet.public : v.id ]
}

output "private_subnet_ids" {
  value = [ for k, v in aws_subnet.private : v.id ] 
}
