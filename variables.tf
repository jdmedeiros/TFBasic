variable "bucket_name" {
  description = "The name of the S3 bucket to store the state. Must be globally unique."
  type        = string
  default     = "jdmedeiros-tfprojects-tfstate"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  type        = string
  default     = "jdmedeiros-tfprojects-tfstate-lock"
}

