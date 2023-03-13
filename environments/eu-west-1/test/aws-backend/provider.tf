terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.00"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}