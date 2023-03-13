output "instance_ip" {
  value = aws_eip.public.public_ip
}

output "secret_key" {
  value     = tls_private_key.terraform.private_key_pem
  sensitive = true
}