terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
  }
}

provider "aws" {
  region = "ap-southeast-2"
  availability_zone = "ap-southeast-2a"
}