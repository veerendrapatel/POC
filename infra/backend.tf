terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"  # Use the created bucket
    key            = "infra/terraform.tfstate"    # A unique key for this stack's state
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"      # Use the created DynamoDB table
  }
}
