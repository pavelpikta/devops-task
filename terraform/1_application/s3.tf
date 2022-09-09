####################################
# S3 bucket that store lambda builds
####################################
module "s3_lambda_builds" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.4.0"

  bucket = "${var.project}-${var.environment}-lambda-builds"
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

##############################
# S3 bucket that store dataset
##############################
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

############################################
# Policy that allow access to statis website
############################################
data "aws_iam_policy_document" "static_page_bucket_policy" {
  statement {
    sid = "PublicReadGetObject"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    effect = "Allow"
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "arn:aws:s3:::${var.project}-${var.environment}-static-page/*",
    ]
  }
}

######################################
# S3 bucket for static website hosting
######################################
module "s3_static_page" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.4.0"

  bucket = "${var.project}-${var.environment}-static-page"
  acl    = "private"

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  # Bucket policies
  attach_policy = true
  policy        = data.aws_iam_policy_document.static_page_bucket_policy.json

  # Allow deletion of non-empty bucket
  force_destroy = true

  versioning = {
    enabled = false
  }

  # S3 bucket website configuration
  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    "Service" = "S3"
  }
}
