resource "aws_s3_bucket" "bucket" {
  bucket = "bucket-testmaximumpigs"

  tags = {
    name = "bucket-testmaximumpigs"
  }
}

resource "aws_iam_role" "S3-Role" {
  name_prefix = "TF_"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "sts:AssumeRole"
        ],
        "Principal" : {
          "Service" : [
            "ec2.amazonaws.com"
          ]
        }
      }
    ]
  })
}

resource "aws_iam_policy" "S3-Policy" {
  name_prefix = "TF_"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:Get*",
          "s3:List*",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3-object-lambda:Get*",
          "s3-object-lambda:List*",
        ],
        Resource = "${aws_s3_bucket.bucket.arn}*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "S3-Attach" {
  role       = aws_iam_role.S3-Role.name
  policy_arn = aws_iam_policy.S3-Policy.arn
}

resource "aws_iam_instance_profile" "profile" {
  name_prefix = "TF_"
  role        = aws_iam_role.S3-Role.name
}