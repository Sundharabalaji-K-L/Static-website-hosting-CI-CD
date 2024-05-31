output "regional_domain_names" {
    value = [for bucket in aws_s3_bucket.this-bucket : bucket.bucket_regional_domain_name]
  
}

output "bucket_domain_names" {
  value = [for bucket in aws_s3_bucket.this-bucket : "http://${bucket.bucket}.s3.amazonaws.com/"]
}

output "bucket_ids" {
  value = aws_s3_bucket.this-bucket[*].id
}

output "bucket_arns" {
  value = aws_s3_bucket.this-bucket[*].arn
}

output "bucket_names" {
  value = aws_s3_bucket.this-bucket[*].bucket
}
