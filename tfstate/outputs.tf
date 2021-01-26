output "tfstate_bucket_name" {
  description = "The name of the S3 bucket to store the state. Must be globally unique."
  value     = "jdmedeiros-tfprojects-tfstate"
}

output "tfstate_dynamodb_table_name" {
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  value     = "jdmedeiros-tfprojects-tfstate-lock"
}

