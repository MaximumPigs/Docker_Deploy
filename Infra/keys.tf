resource "tls_private_key" "terraform" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  public_key = tls_private_key.terraform.public_key_openssh
}

resource "aws_secretsmanager_secret" "generated_key" {
  name = "generated_key"
}

resource "aws_secretsmanager_secret_version" "generated_key" {
  secret_id     = aws_secretsmanager_secret.generated_key.id
  secret_string = tls_private_key.terraform.private_key_pem
}