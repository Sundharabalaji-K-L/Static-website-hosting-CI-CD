resource "aws_iam_instance_profile" "example_instance_profile" {
  name = var.profile_name

  role = var.iam_role
}

resource "aws_instance" "master_machine" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  iam_instance_profile        = aws_iam_instance_profile.example_instance_profile.name
  associate_public_ip_address = "true"
  key_name                    = var.key_name
  volume_tags = {
    volume_size = var.volume
  }
  user_data = file("${var.user_data}")

  tags = {
    Name = var.instance_name
  }

}
