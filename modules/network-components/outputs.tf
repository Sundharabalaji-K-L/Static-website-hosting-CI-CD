output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets_cidirs" {
  value = aws_subnet.public_subnet[*].cidr_block
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnets_cidirs" {
  value = aws_subnet.private_subnet[*].cidr_block
}

output "private_subnets_ids" {
  value = aws_subnet.private_subnet[*].id
}
