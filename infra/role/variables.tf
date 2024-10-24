variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "lambda_role_name" {
  description = "Name of the Lambda role"
  type        = string
  default     = "lambda_video_processing_role"
}

variable "lambda_policy_name" {
  description = "Name of the policy attached to the Lambda role"
  type        = string
  default     = "lambda_kinesis_policy"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}
