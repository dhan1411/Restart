provider "aws" {

region = "ap-south-1"
access_key = var.access_key
secret_key = var.secret_key

}

resource "aws_s3_bucket" "test" {
bucket = "dhan1411"


}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.test.bucket
  versioning_configuration {
    status = "Enabled"

  }
}


resource "aws_s3_bucket_lifecycle_configuration" "versioning-bucket-config" {

  depends_on = [aws_s3_bucket_versioning.versioning]

  bucket = aws_s3_bucket.test.bucket

  rule {
    id = "config"

  transition {
      days          = 30
      storage_class = "STANDARD_IA"

    }

  status = "Enabled"
}
}
