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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.29.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_function_dataset"></a> [lambda\_function\_dataset](#module\_lambda\_function\_dataset) | terraform-aws-modules/lambda/aws | >= 4.0.0 |
| <a name="module_s3_dataset_bucket"></a> [s3\_dataset\_bucket](#module\_s3\_dataset\_bucket) | terraform-aws-modules/s3-bucket/aws | 3.4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.cron](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.dataset_lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cron_expression"></a> [cron\_expression](#input\_cron\_expression) | The cron expression for the schedule | `string` | `"cron(0 12 * * ? *)"` | no |
| <a name="input_dataset_url"></a> [dataset\_url](#input\_dataset\_url) | DATASET URL | `string` | `"https://storage.covid19datahub.io/level/1.csv"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | `"dev"` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | `"devops"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dataset_s3_bucket_arn"></a> [dataset\_s3\_bucket\_arn](#output\_dataset\_s3\_bucket\_arn) | Dataset AWS S3 bucket ARN |
| <a name="output_dataset_s3_bucket_name"></a> [dataset\_s3\_bucket\_name](#output\_dataset\_s3\_bucket\_name) | Dataset AWS S3 bucket name |
<!-- END_TF_DOCS -->