resource "aws_ebs_volume" "storage" {
  availability_zone = "ap-southeast-2"
  size              = 5

  tags = {
    Name = "Persistent Storage"
  }
}