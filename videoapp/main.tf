provider "aws" {
  region = var.aws_region
}

# Fetch remote state from the infra stack for IAM role
data "terraform_remote_state" "infra_role" {
  backend = "s3"
  config = {
    bucket = "my-infra-terraform-state"
    key    = "infra/terraform.tfstate"
    region = var.aws_region
  }
}

# Lambda function to process Kinesis Video Stream
resource "aws_lambda_function" "video_analyzer" {
  function_name = var.lambda_function_name
  role          = data.terraform_remote_state.infra_role.outputs.lambda_role_arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  s3_bucket     = var.lambda_code_s3_bucket
  s3_key        = var.lambda_code_s3_key

  environment {
    variables = {
      DYNAMO_TABLE = aws_dynamodb_table.video_metadata.name
      S3_BUCKET    = aws_s3_bucket.processed_videos.bucket
    }
  }

  timeout = var.lambda_timeout
}

# Kinesis Video Stream resource
resource "aws_kinesis_video_stream" "video_stream" {
  name = var.kinesis_stream_name
}

# DynamoDB table for storing video metadata
resource "aws_dynamodb_table" "video_metadata" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "VideoID"

  attribute {
    name = "VideoID"
    type = "S"
  }
}

# S3 bucket for processed video output
resource "aws_s3_bucket" "processed_videos" {
  bucket = var.processed_videos_bucket
}
