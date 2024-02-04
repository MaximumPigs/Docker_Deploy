resource "aws_security_group" "security_group" {
  name        = "security_group"
  description = "firewall rules"
  vpc_id      = aws_vpc.vpc.id
}

# GENERAL

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.security_group.id
  description       = "all outbound"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
}

resource "aws_vpc_security_group_ingress_rule" "ssh_inbound_runner_ip" {
  count             = var.runner_access_enabled == true ? 1 : 0
  security_group_id = aws_security_group.security_group.id
  description       = "SSH Inbound from runner and my OP"
  from_port         = 22
  cidr_ipv4         = "${chomp(data.http.myip.response_body)}/32"
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "ssh_inbound_my_ip" {
  security_group_id = aws_security_group.security_group.id
  description       = "SSH Inbound from runner and my OP"
  from_port         = 22
  cidr_ipv4         = "${coalesce(var.my_ip, "192.168.0.1")}/32"
  to_port           = 22
  ip_protocol       = "tcp"
}

# PALWORLD

resource "aws_vpc_security_group_ingress_rule" "palworld_server" {
  count             = var.game == "palworld" ? 1 : 0
  security_group_id = aws_security_group.security_group.id
  description       = "Palworld Server Inbound"
  from_port         = 8211
  cidr_ipv4         = "0.0.0.0/0"
  to_port           = 8211
  ip_protocol       = "udp"
}

# ENSHROUDED

resource "aws_vpc_security_group_ingress_rule" "enshrouded_server_udp" {
  count             = var.game == "enshrouded" ? 1 : 0
  security_group_id = aws_security_group.security_group.id
  description       = "Enshrouded Server Inbound"
  from_port         = 15636
  cidr_ipv4         = "0.0.0.0/0"
  to_port           = 15637
  ip_protocol       = "udp"
}

resource "aws_vpc_security_group_ingress_rule" "enshrouded_server_tcp" {
  count             = var.game == "enshrouded" ? 1 : 0
  security_group_id = aws_security_group.security_group.id
  description       = "Enshrouded Server Inbound"
  from_port         = 15636
  cidr_ipv4         = "0.0.0.0/0"
  to_port           = 15637
  ip_protocol       = "tcp"
}