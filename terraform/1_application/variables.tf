variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  default     = "dev"
}

variable "project" {
  description = "Project name"
  default     = "devops"
}

variable "dataset_url" {
  description = "DATASET URL"
  default     = "https://storage.covid19datahub.io/level/1.csv"
}

variable "cron_expression" {
  description = "The cron expression for the schedule"
  default     = "cron(0 12 * * ? *)"
}
