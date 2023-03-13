terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }
  }
  backend "s3" {}
}

provider "docker" {
  host     = "ssh://ubuntu@${var.instance_ip}:22"
  ssh_opts = ["-i id_rsa"]
}
