output "security_group_arn" {
    value = aws_security_group.allow_traffic.arn
}

output "security_group_id" {
  value = aws_security_group.allow_traffic.id
}

