<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | >= 1.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 1.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.30.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_function_dataset"></a> [lambda\_function\_dataset](#module\_lambda\_function\_dataset) | terraform-aws-modules/lambda/aws | >= 4.0.0 |
| <a name="module_lambda_function_parse"></a> [lambda\_function\_parse](#module\_lambda\_function\_parse) | terraform-aws-modules/lambda/aws | >= 4.0.0 |
| <a name="module_s3_dataset_bucket"></a> [s3\_dataset\_bucket](#module\_s3\_dataset\_bucket) | terraform-aws-modules/s3-bucket/aws | 3.4.0 |
| <a name="module_s3_lambda_builds"></a> [s3\_lambda\_builds](#module\_s3\_lambda\_builds) | terraform-aws-modules/s3-bucket/aws | 3.4.0 |
| <a name="module_s3_static_page"></a> [s3\_static\_page](#module\_s3\_static\_page) | terraform-aws-modules/s3-bucket/aws | 3.4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.cron](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.dataset_lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_lambda_permission.allow_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket_notification.bucket_notification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_iam_policy_document.static_page_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_country"></a> [country](#input\_country) | ENV variable for Lambda function that will be use to parse dataset | `string` | `"US"` | no |
| <a name="input_cron_expression"></a> [cron\_expression](#input\_cron\_expression) | The cron expression for the schedule | `string` | `"cron(0 12 * * ? *)"` | no |
| <a name="input_dataset_url"></a> [dataset\_url](#input\_dataset\_url) | DATASET URL | `string` | `"https://storage.covid19datahub.io/level/1.csv"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | `"dev"` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | `"devops"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dataset_s3_bucket_name"></a> [dataset\_s3\_bucket\_name](#output\_dataset\_s3\_bucket\_name) | Dataset AWS S3 bucket name |
| <a name="output_lambda_builds_s3_bucket_name"></a> [lambda\_builds\_s3\_bucket\_name](#output\_lambda\_builds\_s3\_bucket\_name) | AWS S3 bucket name for lambda buils |
| <a name="output_static_page_endpoint"></a> [static\_page\_endpoint](#output\_static\_page\_endpoint) | The website endpoint |
| <a name="output_static_page_url"></a> [static\_page\_url](#output\_static\_page\_url) | The website url |
| <a name="output_static_pages_s3_bucket_name"></a> [static\_pages\_s3\_bucket\_name](#output\_static\_pages\_s3\_bucket\_name) | Static page AWS S3 bucket name |
<!-- END_TF_DOCS -->