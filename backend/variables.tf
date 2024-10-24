variable "aws_profile" {
  description = "The AWS profile to use"
  type        = string
  default     = "577411803844_AdministratorAccess"
}
variable "aws_region" {
  description = "AWS Region"
  default     = "eu-north-1"
}
variable "s3_bucket_name" {
  description = "Name of the S3 bucket for storing Terraform state"
  type        = string
  default     = "terraform-state-bucket"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
  type        = string
  default     = "terraform-state-locks"
}