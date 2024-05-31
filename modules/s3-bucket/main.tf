resource "aws_s3_bucket" "this-bucket" {
  count  = length(var.s3_names)
  bucket = element(var.s3_names, count.index)
  tags = {
    name = element(var.s3_names, count.index)
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  count  = length(var.s3_names)
  bucket = aws_s3_bucket.this-bucket[count.index].id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default_encryption" {
  count = length(var.s3_names)
  bucket = aws_s3_bucket.this-bucket[count.index].id  # Reference your S3 bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
