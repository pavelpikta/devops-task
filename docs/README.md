# Documentation

## How it works

Prefer for this solution it use AWS Serverless services (Lambda)
Easy to setup and manage, low costs.

This solution contains Lambda functions and S3 buckets that managed by Terraform:

- [dataset-uploader](../lambda/dataset-uploader/lambda_function.py)

  This Lambda function runs by Schedule event(cron expression) on AWS EventBridge service,
  downloads Dataset from OpenSource [COVID-19 Data Hub](https://covid19datahub.io/index.html)
  and store downloaded Dataset on AWS S3 bucket.

- [dataset-parser](../lambda/dataset-parser/lambda_function.py)

  This Lambda function runs by S3 Notification event when some Dataset uploaded to AWS S3 bucket that contains Datasets.  
  After receiving notification event, Lambda function get object from S3 bucket, parse Dataset with specific
  parameters(getting data for specific country, select only useful columns, sort by latest datetime)

- [terraform-application](../terraform/1_application/README.md)
  IaC solution that deploy all necessary resources:
  
  - S3 buckets for Lambda builds, dataset store, static website()
  - Lambda functions
  - Event Bridge rule(cron expression)
  - S3 bucket notification event

TBD Diagram

### Prerequisites

- [AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)
- [AWS credentials](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html)
- [Python3.8](https://www.python.org/downloads/release/python-380/)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

### Usage

- Setup all [prerequisites](#prerequisites)
- Go to terraform application folder
- Setup necessary variables.
- Run command

```bash
terraform apply -var-file=<path to your variables>
```

### GitHub Actions(CI/CD)

- [Job](../.github/workflows/terraform-fmt-check.yml) that validate config files to canonical terraform format
- [Deploy](../.github/workflows/deploy.yml) simple deploy GitHub job
