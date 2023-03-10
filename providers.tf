terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.1"
    }
  }
  backend "s3" {}
}

provider "docker" {
  host = "ssh://ubuntu@${module.aws_provision.public_ip}:22"
}
