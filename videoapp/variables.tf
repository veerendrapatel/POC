variable "aws_region" {
  description = "AWS region to deploy Lambda and associated resources"
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "video_analyzer_lambda"
}

variable "lambda_handler" {
  description = "Handler method for the Lambda function"
  type        = string
  default     = "index.handler"
}

variable "lambda_runtime" {
  description = "Runtime environment for the Lambda function"
  type        = string
  default     = "python3.9"
}

variable "lambda_code_s3_bucket" {
  description = "S3 bucket where the Lambda deployment package is stored"
  type        = string
}

variable "lambda_code_s3_key" {
  description = "S3 key of the Lambda deployment package"
  type        = string
}

variable "lambda_timeout" {
  description = "Timeout value (in seconds) for the Lambda function execution"
  type        = number
  default     = 300
}

variable "kinesis_stream_name" {
  description = "Name of the Kinesis Video Stream"
  type        = string
  default     = "video-analysis-stream"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for storing video metadata"
  type        = string
  default     = "video_metadata_table"
}

variable "processed_videos_bucket" {
  description = "Name of the S3 bucket where processed videos will be stored"
  type        = string
}