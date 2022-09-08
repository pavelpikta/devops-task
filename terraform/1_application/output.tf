output "dataset_s3_bucket_arn" {
  description = "Dataset AWS S3 bucket ARN"
  value       = module.s3_dataset_bucket.s3_bucket_arn
}

output "dataset_s3_bucket_name" {
  description = "Dataset AWS S3 bucket name"
  value       = module.s3_dataset_bucket.s3_bucket_id
}
