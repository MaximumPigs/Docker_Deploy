resource "tls_private_key" "terraform" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  public_key = tls_private_key.terraform.public_key_openssh
}

resource "aws_iam_policy" "game_s3_access" {
  name = "s3_access_${var.environment}_${var.game}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "ec2AssumeRole",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        "Resource" : [
          "arn:aws:s3:::game-files-maximumpigs/${var.environment}/${var.game}/*",
          "arn:aws:s3:::game-files-maximumpigs"
        ]
      },
    ]
  })
}

resource "aws_iam_role" "ec2_s3_access" {
  name = "ec2_s3_access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "ec2AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns = [aws_iam_policy.game_s3_access.arn]

  tags = {
    "project" = "game_servers"
    "game"    = var.game
  }
}

resource "aws_iam_instance_profile" "s3_access" {
  name = "s3_access_${var.environment}_${var.game}"
  role = aws_iam_role.ec2_s3_access.name
}
