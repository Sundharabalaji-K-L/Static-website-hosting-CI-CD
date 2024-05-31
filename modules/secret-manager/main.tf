resource "aws_secretsmanager_secret" "example" {
  name = var.secret_name
  description = var.description
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = var.secret_string
}