output "s3_backend_bucket_name" {
  value = module.backend.s3_backend_bucket_name
}

output "dynamodb_lock_table_name" {
  value = module.backend.dynamodb_lock_table_name
}

output "dynamodb_lock_table_arn" {
  value = module.backend.dynamodb_lock_table_arn
}