data "http" "myip" {
  url = "https://ipv4.icanhazip.com/"
}

data "aws_region" "current" {}