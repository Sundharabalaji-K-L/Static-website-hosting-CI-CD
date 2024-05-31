resource "aws_iam_role" "iam-role" {
  name = var.role_name
  assume_role_policy = var.assume_role_policy
  tags = {
    Name = var.role_name
  }
}

