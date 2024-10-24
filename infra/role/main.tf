provider "aws" {
  region = var.aws_region
}

# Create an IAM role for Lambda to interact with Kinesis, DynamoDB, and S3
resource "aws_iam_role" "lambda_role" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# Create an IAM policy for Lambda to access Kinesis, S3, and DynamoDB
resource "aws_iam_policy" "lambda_policy" {
  name        = var.lambda_policy_name
  description = "Policy for Lambda to interact with Kinesis, S3, and DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "kinesisvideo:GetMedia",
          "kinesisvideo:GetDataEndpoint",
          "kinesisvideo:ListStreams"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:s3:::${var.s3_bucket_name}/*"
      },
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:UpdateItem"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:dynamodb:*:*:table/${var.dynamodb_table_name}"
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
