terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

module "iam" {
  source = "./iam"
}

module "ec2" {
  source = "./ec2"
}
