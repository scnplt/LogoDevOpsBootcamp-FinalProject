terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Variables
variable "region" { type = string }
variable "accountID" { type = number }
variable "containerPort" { type = number }
variable "imageName" { type = string }

# Provider
provider "aws" {
  region = var.region
}

# Modules
module "ec2" {
  source = "./aws/ec2"
  vpcCidrBlock  = "10.0.0.0/16"
  vpcName       = "LogoVPC"
  region        = var.region
  publicPort    = 80
  containerPort = var.containerPort
}

module "ecs" {
  source = "./aws/ecs"
  clusterName         = "LogoCluster"
  containerName       = "app-container"
  accountID           = var.accountID
  imageURL            = "${var.accountID}.dkr.ecr.${var.region}.amazonaws.com/${var.imageName}"
  containerPort       = var.containerPort
  serviceName         = "app-service"
  desiredCount        = 2
  lbTargetGroupArn    = module.ec2.lbTargetGroupArn
  publicSubnetIDs     = module.ec2.publicSubnetIDs
  appSecurityGroupIDs = module.ec2.appSecurityGroupIDs
  depends_on = [module.ec2]
}