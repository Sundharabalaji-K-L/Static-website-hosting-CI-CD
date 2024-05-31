resource "aws_security_group" "allow_traffic" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.sg_name
  }
}

resource "aws_security_group_rule" "ingress-rule" {
    for_each = var.ingress_rules
    type              = each.value.type
    from_port         = each.value.from_port
    to_port           = each.value.to_port
    protocol          = each.value.protocol
    cidr_blocks       = each.value.cidr_blocks
    security_group_id = aws_security_group.allow_traffic.id
}

resource "aws_security_group_rule" "egress-rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_traffic.id
}