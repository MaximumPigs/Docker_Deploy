resource "aws_instance" "my_instance" {

  ami                         = "ami-08f0bc76ca5236b20"
  instance_type               = "t2.medium"
  key_name                    = var.key_pair
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = ["${aws_security_group.security_group.id}"]

  root_block_device {
    delete_on_termination = true
    volume_size           = "15"
  }

  tags = {
    "name" = "Instance"
  }

  user_data_base64 = base64encode(templatefile("cloudinit/userdata.tmpl", { gen_key = tls_private_key.terraform.public_key_openssh }))
}


resource "aws_ec2_instance_state" "power" {
  instance_id = aws_instance.my_instance.id
  state       = var.instance_state
}