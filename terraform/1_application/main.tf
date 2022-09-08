terraform {
  backend "local" {}
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project
      TF_MANAGED  = "true"
      TF_REPO     = "https://github.com/pavelpikta/devops-task"
    }
  }
}
