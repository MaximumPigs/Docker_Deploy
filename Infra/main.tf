resource "aws_instance" "my_instance" {
  depends_on = [
    aws_network_interface.honeypot_nic
  ]

  ami           = "ami-08f0bc76ca5236b20"
  instance_type = "t2.micro"
  key_name      = var.key_pair

  tags = {
    "name" = "Honeypot"
  }

  network_interface {
    network_interface_id = aws_network_interface.honeypot_nic.id
    device_index         = 0
  }

  user_data_base64 = base64encode(templatefile("cloudinit/userdata.tmpl", { gen_key = tls_private_key.terraform.public_key_openssh }))
}

resource "aws_network_interface" "honeypot_nic" {
  subnet_id       = aws_subnet.subnet.id
  security_groups = ["${aws_security_group.security_group.id}"]

  tags = {
    "name" = "primary_network_interface"
  }
}

resource "aws_eip" "public" {
  depends_on = [
    aws_internet_gateway.gw,
    aws_instance.my_instance
  ]

  network_interface         = aws_network_interface.honeypot_nic.id
  associate_with_private_ip = aws_network_interface.honeypot_nic.private_ip
  vpc                       = true
}