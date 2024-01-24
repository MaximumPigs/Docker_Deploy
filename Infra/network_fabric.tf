resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/24"

  tags = {
    "name" = "vpc"
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
    "name" = "subnet"
  }
}

resource "aws_default_route_table" "route" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    name = "Route"
  }
}

resource "aws_security_group" "security_group" {
  name        = "security_group"
  description = "firewall rules"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "ssh_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.security_group.id
  description       = "SSH Inbound from runner and my OP"
  from_port         = 22
  cidr_blocks       = ["${coalesce(var.my_ip, "192.168.0.1")}/32", "${chomp(data.http.myip.response_body)}/32"]
  to_port           = 22
  protocol          = "tcp"
}

resource "aws_security_group_rule" "game_server" {
  type              = "ingress"
  security_group_id = aws_security_group.security_group.id
  description       = "Game Server Inbound"
  from_port         = 8211
  cidr_blocks       = ["0.0.0.0/0"]
  to_port           = 8211
  protocol          = "udp"
}

resource "aws_security_group_rule" "all" {
  type              = "egress"
  security_group_id = aws_security_group.security_group.id
  description       = "all outbound"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = -1
}