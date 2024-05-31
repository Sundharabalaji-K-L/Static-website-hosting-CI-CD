resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {

    Name = var.vpc_name

  }

}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.public_subnets_cidrs)
  cidr_block        = element(var.public_subnets_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.prefix}-public-subnet-az-${count.index+1}"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.ig_name
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  count          = length(aws_subnet.public_subnet[*].id)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.private_subnets_cidrs)
  cidr_block        = element(var.private_subnets_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "${var.prefix}-Private Subnet-az-${count.index+1}"
  }
}

resource "aws_eip" "nat-gateway-eip" {
  depends_on = [aws_route_table.public_route_table]
  domain     = "vpc"
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat-gateway-eip.id
  subnet_id     = aws_subnet.public_subnet[0].id
  depends_on    = [aws_internet_gateway.internet_gateway]
  tags = {
    Name = var.nat_name
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway.id
  }
  tags = {
    Name : var.private_route_table_name
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  count          = length(aws_subnet.private_subnet[*].id)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_network_acl" "public_acl" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = var.public_acl_name
  }
}

resource "aws_network_acl_association" "public_acl_association" {
  count          = length(aws_subnet.public_subnet[*].id)
  network_acl_id = aws_network_acl.public_acl.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}

resource "aws_network_acl" "private_acl" {
  vpc_id = aws_vpc.main.id

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = aws_subnet.public_subnet[0].cidr_block
    from_port  = 443
    to_port    = 443
  }


  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = var.private_acl_name
  }
}

resource "aws_network_acl_association" "private_acl_association" {
  count          = length(aws_subnet.private_subnet[*].id)
  network_acl_id = aws_network_acl.private_acl.id
  subnet_id      = aws_subnet.private_subnet[count.index].id
}

