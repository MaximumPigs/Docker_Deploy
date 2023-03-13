terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
  backend "s3" {
    region = "ap-southeast-2"
    bucket = "terraform-backend-maximumpigs"
    key    = "state/terraform.tfstate"
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

provider "tls" {}