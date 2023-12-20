resource "aws_s3_bucket" "tfstate" {
  bucket = local.env.bucket_name
  # region = local.env.region
  acl = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }
}
