terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    github = {
      source = "integrations/github"

    }
  }


}
provider "aws" {
  region = var.aws_region
}

provider "github" {
  token = var.tf_token
  owner = "Sundharabalaji-1Cloudhub"
}