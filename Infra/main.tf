resource "aws_instance" "my_instance" {

  ami                         = "ami-08f0bc76ca5236b20"
  instance_type               = "t3.medium"
  key_name                    = var.key_pair
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet.id
  security_groups             = ["${aws_security_group.security_group.id}"]

  tags = {
    "name" = "Instance"
  }

  network_interface {
    network_interface_id = aws_network_interface.nic.id
    device_index         = 0
  }

  user_data_base64 = base64encode(templatefile("cloudinit/userdata.tmpl", { gen_key = tls_private_key.terraform.public_key_openssh }))
}