#########################################
# Lambda to upload dataset from URL to S3
#########################################
module "lambda_function_dataset" {
  source  = "terraform-aws-modules/lambda/aws"
  version = ">= 4.0.0"

  function_name = "${var.project}-${var.environment}-dataset-uploader"
  description   = "Lamda function that download dataset from URL and save to S3 bucket"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"

  publish    = true
  hash_extra = "${var.project}-${var.environment}-dataset-uploader"

  memory_size = 512
  timeout     = 30

  source_path = [
    {
      path             = "${path.module}/../../lambda/dataset-uploader"
      pip_requirements = true # Will run "pip install" with default requirements.txt
    }
  ]

  store_on_s3 = true
  s3_bucket   = module.s3_lambda_builds.s3_bucket_id
  s3_prefix   = "lambda-builds/"

  artifacts_dir = "${path.root}/.terraform/lambda-builds/"

  environment_variables = {
    DATASET_URL       = var.dataset_url
    DATASET_S3_BUCKET = module.s3_dataset_bucket.s3_bucket_id
  }

  allowed_triggers = {
    UploaderRule = {
      principal  = "events.amazonaws.com"
      source_arn = aws_cloudwatch_event_rule.cron.arn
    }
  }

  attach_policy_statements = true
  policy_statements = {
    s3_access = {
      effect = "Allow",
      actions = [
        "s3:Put*",
        "s3:Get*",
        "s3:Delete*"
      ],
      resources = ["arn:aws:s3:::${module.s3_dataset_bucket.s3_bucket_id}/*"]
    }
  }

  depends_on = [
    module.s3_dataset_bucket,
    module.s3_lambda_builds
  ]
}

##################################
# Cloudwatch Events (EventBridge)
##################################
resource "aws_cloudwatch_event_rule" "cron" {
  name                = "${var.project}-${var.environment}-uploader-rule"
  description         = "Cron expression to triger dataset-uploader lambda"
  schedule_expression = var.cron_expression
}

resource "aws_cloudwatch_event_target" "dataset_lambda_function" {
  rule = aws_cloudwatch_event_rule.cron.name
  arn  = module.lambda_function_dataset.lambda_function_arn
}

################################################
# Lambda that parse dataset and deploy html page
################################################
module "lambda_function_parse" {
  source  = "terraform-aws-modules/lambda/aws"
  version = ">= 4.0.0"

  function_name = "${var.project}-${var.environment}-dataset-parser"
  description   = "Lamda function that download dataset from URL and save to S3 bucket"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"

  publish    = true
  hash_extra = "${var.project}-${var.environment}-dataset-parser"

  memory_size = 512
  timeout     = 60

  source_path = [
    {
      path             = "${path.module}/../../lambda/dataset-parser"
      pip_requirements = true # Will run "pip install" with default requirements.txt
    }
  ]

  store_on_s3 = true
  s3_bucket   = module.s3_lambda_builds.s3_bucket_id
  s3_prefix   = "lambda-builds/"

  artifacts_dir = "${path.root}/.terraform/lambda-builds/"

  environment_variables = {
    COUNTRY_CODE          = var.country
    STATIC_PAGE_S3_BUCKET = module.s3_static_page.s3_bucket_id
  }

  attach_policy_statements = true
  policy_statements = {
    s3_access = {
      effect = "Allow",
      actions = [
        "s3:Put*",
        "s3:Get*",
        "s3:Delete*"
      ],
      resources = [
        "arn:aws:s3:::${module.s3_dataset_bucket.s3_bucket_id}/*",
        "arn:aws:s3:::${module.s3_static_page.s3_bucket_id}/*"
      ]
    }
  }

  depends_on = [
    module.s3_dataset_bucket,
    module.s3_lambda_builds,
    module.s3_static_page
  ]
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function_parse.lambda_function_arn
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3_dataset_bucket.s3_bucket_arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = module.s3_dataset_bucket.s3_bucket_id

  lambda_function {
    lambda_function_arn = module.lambda_function_parse.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".csv"
  }
}
