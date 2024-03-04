data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  bucket_name         = var.bucket_name != null ? var.bucket_name : "terraform-state-${data.aws_caller_identity.current.account_id}"
  dynamodb_table_name = var.dynamodb_table_name != null ? var.dynamodb_table_name : "terraform-state-${data.aws_caller_identity.current.account_id}"
}
resource "aws_s3_bucket" "state" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket_versioning" "state" {
  bucket = aws_s3_bucket.state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "state" {
  name         = local.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

output "region" {
  value = data.aws_region.current.name
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "bucket" {
  value = aws_s3_bucket.state.id
}

output "dynamodb_table" {
  value = aws_dynamodb_table.state.id
}
