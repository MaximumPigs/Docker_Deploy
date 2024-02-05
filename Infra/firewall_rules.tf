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

# Dynamic port based on game choice - defined in locals.tf

resource "aws_vpc_security_group_ingress_rule" "Game_Inbound" {
  for_each = {for index, port in local.games[var.game].ports: port.index => port}

  security_group_id = aws_security_group.security_group.id
  description       = "${var.game} Server Inbound Rule ${each.key}"
  from_port         = each.value.start_port
  cidr_ipv4         = "0.0.0.0/0"
  to_port           = each.value.end_port
  ip_protocol       = each.value.protocol 
}