resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/24"

  tags = {
    "name" = "honeypot_vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "subnet" {
  depends_on = [
    aws_internet_gateway.gw
  ]

  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    "name" = "honeypot_subnet"
  }
}

resource "aws_default_route_table" "route" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    name = "Honeypot Route"
  }
}

resource "aws_security_group" "security_group" {
  name        = "honeypot_security_group"
  description = "firewall rules for honeypot"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    cidr_blocks = ["${var.my_ip}/32"]
    to_port     = 22
    protocol    = "tcp"
  }

  egress {
    description = "all outbound"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = -1
  }
}