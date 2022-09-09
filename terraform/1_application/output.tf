output "dataset_s3_bucket_name" {
  description = "Dataset AWS S3 bucket name"
  value       = module.s3_dataset_bucket.s3_bucket_id
}

output "static_pages_s3_bucket_name" {
  description = "Static page AWS S3 bucket name"
  value       = module.s3_static_page.s3_bucket_id
}

output "lambda_builds_s3_bucket_name" {
  description = "AWS S3 bucket name for lambda buils"
  value       = module.s3_lambda_builds.s3_bucket_id
}

output "static_page_endpoint" {
  description = "The website endpoint"
  value       = try(module.s3_static_page.s3_bucket_website_endpoint, "")
}

output "static_page_url" {
  description = "The website url"
  value       = try("http://${module.s3_static_page.s3_bucket_website_endpoint}", "")
}
