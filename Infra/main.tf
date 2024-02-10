resource "aws_instance" "my_instance" {

  ami                         = "ami-08f0bc76ca5236b20"
  instance_type               = local.games[var.game].vm_size[var.vm_size].type
  key_name                    = var.key_pair
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet.id
  vpc_security_group_ids      = ["${aws_security_group.security_group.id}"]
  iam_instance_profile        = aws_iam_instance_profile.s3_access.name

  root_block_device {
    delete_on_termination = true
    volume_size           = local.games[var.game].disk_size
  }

  tags = {
    "project" = "game_servers"
    "game"    = var.game
  }

  credit_specification {
    cpu_credits = "standard"
  }

  user_data_base64 = base64encode(templatefile("cloudinit/userdata.tmpl", {
    gen_key     = tls_private_key.terraform.public_key_openssh,
    game        = var.game
    environment = var.environment
    save_dirs   = local.games[var.game].save_dirs,
    save_files  = local.games[var.game].save_files,
    swap_size   = local.games[var.game].swap_size
  }))
}