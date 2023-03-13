output "s3_backend_bucket_name" {
  value = aws_s3_bucket.tf_backend_bucket.id
}

output "dynamodb_lock_table_name" {
  value = aws_dynamodb_table.tf_locks[0].id
}

output "dynamodb_lock_table_arn" {
  value = aws_dynamodb_table.tf_locks[0].arn
}