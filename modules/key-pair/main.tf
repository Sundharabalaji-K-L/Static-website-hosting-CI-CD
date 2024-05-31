resource "tls_private_key" "terrafrom_generated_private_key" {

  algorithm = "RSA"

  rsa_bits = 4096

}

resource "aws_key_pair" "generated_key" {

  key_name   = var.key_name
  public_key = tls_private_key.terrafrom_generated_private_key.public_key_openssh
}

resource "local_file" "private_key_file" {
  content  = tls_private_key.terrafrom_generated_private_key.private_key_pem
  filename = "static-website-hosting-Jenkins-server-key.pem"
}