terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.00"
    }
  }
  backend "s3" {
    encrypt = true
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}