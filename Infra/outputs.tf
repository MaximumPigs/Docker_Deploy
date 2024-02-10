output "instance_ip" {
  value = aws_instance.my_instance.public_ip
}

output "secret_key" {
  value     = tls_private_key.terraform.private_key_pem
  sensitive = true
}

output "memory" {
  value = local.games[var.game].vm_size[var.vm_size].memory
}