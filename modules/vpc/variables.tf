
variable "vpc_bucket_name" {
  description = "The name of the S3 bucket to store the state."
  type        = string
  default     = ""
}

variable "vpc_bucket_key_name" {
  description = "The name of the S3 bucket folder to store the state."
  type        = string
  default     = ""
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table. Must be unique in this AWS account."
  type        = string
  default     = ""
}


variable "vpc_cidr_block" {
  default = "172.16.0.0/16"
}

variable "top_cidr_block" {
  default = "172.16.0.0/24"
}

variable "bottom_cidr_block" {
  default = "172.16.1.0/24"
}
