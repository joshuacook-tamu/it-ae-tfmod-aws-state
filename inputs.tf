variable "bucket_name" {
  description = "The name of the S3 bucket to create for storing the Terraform state"
  type        = string
  default     = null
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table to create for storing the Terraform state lock"
  type        = string
  default     = null
}
