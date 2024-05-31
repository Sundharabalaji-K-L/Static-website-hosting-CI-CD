resource "aws_s3_bucket_policy" "example_policy" { 
    bucket = var.bucket_name
    policy = var.policies
}