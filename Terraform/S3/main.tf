resource "aws_s3_bucket" "example12" {
  bucket = "example12"
}

resource "aws_s3_bucket_ownership_controls" "example1" {
  bucket = aws_s3_bucket.example12.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_public_access_block" "example2" {
  bucket = aws_s3_bucket.example12.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.example12.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example3" {
  bucket = aws_s3_bucket.example12.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}