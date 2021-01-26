# Create an S3 bucket to store all tf states related to the projects inside this folder
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }

  #  Carefully consider the following block; REMOVE it if you are in a production environment
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
    mfa_delete = false
  }
}

# Explicitly restrict public access
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  block_public_acls = true
  block_public_policy = true
  bucket = aws_s3_bucket.terraform_state.bucket
  ignore_public_acls = true
  restrict_public_buckets = true
}

# Dynamo DB table created to implement access lock
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}