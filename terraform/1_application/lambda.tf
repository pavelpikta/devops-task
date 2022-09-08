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
  timeout     = 60

  source_path = [
    {
      path             = "${path.module}/../../lambda/dataset-uploader"
      pip_requirements = true # Will run "pip install" with default requirements.txt
    }
  ]

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

  depends_on = [
    module.s3_dataset_bucket
  ]
}

##################################
# Cloudwatch Events (EventBridge)
##################################
resource "aws_cloudwatch_event_rule" "cron" {
  name                = "${var.project}-${var.environment}-uploader-rule"
  description         = "Cron expression to triger dataset-uploader lambda"
  schedule_expression = "cron(0 12 * * ? *)"
}

resource "aws_cloudwatch_event_target" "dataset_lambda_function" {
  rule = aws_cloudwatch_event_rule.cron.name
  arn  = module.lambda_function_dataset.lambda_function_arn
}
