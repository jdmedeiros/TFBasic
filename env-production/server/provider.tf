terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.25.0"
    }
  }
  backend "s3" {
    bucket = "jdmedeiros-tfprojects-tfstate"
    key = "env-production/server/terraform-tfstate"
    region = "us-east-1"
    dynamodb_table = "jdmedeiros-tfprojects-tfstate-lock"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}

