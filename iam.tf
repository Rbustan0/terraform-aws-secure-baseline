resource "aws_iam_role" "terraform_execution" {
  name = "terraform-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name    = "terraform-execution-role"
    Project = "terraform-aws-secure-baseline"
  }
}

resource "aws_iam_role_policy" "terraform_execution" {
  name = "terraform-execution-policy"
  role = aws_iam_role.terraform_execution.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "s3:GetObject",
          "s3:PutObject",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "terraform_execution" {
  name = "terraform-execution-profile"
  role = aws_iam_role.terraform_execution.name

  tags = {
    Name    = "terraform-execution-profile"
    Project = "terraform-aws-secure-baseline"
  }
}