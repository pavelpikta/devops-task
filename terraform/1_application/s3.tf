module "s3_dataset_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.4.0"

  bucket = "${var.project}-${var.environment}-dataset"
  acl    = "private"

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # Allow deletion of non-empty bucket
  force_destroy = true

  versioning = {
    enabled = false
  }

  tags = {
    "Service" = "S3"
  }
}
