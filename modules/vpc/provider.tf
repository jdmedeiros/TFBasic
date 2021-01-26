terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.25.0"
    }
  }
  backend "s3" {
    bucket = var.vpc_bucket_name
    key = var.vpc_bucket_key_name
    region = "us-east-1"
    dynamodb_table = var.dynamodb_table_name
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}
