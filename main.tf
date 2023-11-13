terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "http" {}
}

# Variables
variable "region" { type = string }
variable "clusterName" { type = string }
variable "serviceName" { type = string }
variable "accountID" { type = number }
variable "containerPort" { type = number }
variable "imageURL" { type = string }

# Provider
provider "aws" {
  region = var.region
}

# Modules
module "iam" {
  source = "./aws/iam"
}

module "ec2" {
  source = "./aws/ec2"

  vpcCidrBlock  = "10.0.0.0/16"
  vpcName       = "LogoVPC"
  publicPort    = 80
  containerPort = var.containerPort
}

module "ecs" {
  source = "./aws/ecs"

  clusterName         = var.clusterName
  containerName       = "app-container"
  executionRoleArn    = module.iam.ecsTaskExecutionRoleArn
  imageURL            = var.imageURL
  containerPort       = var.containerPort
  serviceName         = var.serviceName
  desiredCount        = 2
  lbTargetGroupArn    = module.ec2.lbTargetGroupArn
  publicSubnetIDs     = module.ec2.publicSubnetIDs
  appSecurityGroupIDs = module.ec2.appSecurityGroupIDs
}

module "autoscaling" {
  source = "./aws/autoscaling"

  clusterName         = var.clusterName
  serviceName         = var.serviceName
  maxCapacity         = 4
  minCapacity         = 1
  ecsAutoscaleRoleArn = module.iam.ecsAutoscaleRoleArn

  depends_on = [module.ecs]
}

module "cloudwatch" {
  source = "./aws/cloudwatch"

  clusterName           = var.clusterName
  serviceName           = var.serviceName
  scaleInPolicyArn      = module.autoscaling.scaleInPolicyArn
  scaleOutPolicyArn     = module.autoscaling.scaleOutPolicyArn
  dashboardName         = "${var.clusterName}Dashboard"
  region                = var.region
  dashboardPeriod       = 30
  loadBalancerArnSuffix = module.ec2.loadBalancerArnSuffix

  depends_on = [module.ecs]
}
