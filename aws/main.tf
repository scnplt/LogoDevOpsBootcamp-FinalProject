terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# module "iam" {
#   source = "./iam"
# }

module "ec2" {
  source = "./ec2"

  vpc_name          = "MainVPC"
  vpc_cidr_block    = "10.1.0.0/16"
  public_port       = 80
  container_port    = var.container_port
  target_group_name = "AppTargetGroup"
  lb_name           = "AppLoadBalancer"
  subnet_confs = [
    {
      cidr_block        = "10.1.1.0/24"
      availability_zone = "${var.region}a"
    },
    {
      cidr_block        = "10.1.2.0/24"
      availability_zone = "${var.region}b"
  }]

  # depends_on = [module.iam]
}

module "ecs" {
  source = "./ecs"

  cluster_name            = "MainCluster"
  service_name            = "AppService"
  desired_count           = 2
  task_execution_role_arn = "arn:aws:iam::${var.account_id}:role/ecsTaskExecutionRole"
  target_group_arn        = module.ec2.lb_target_group_arn
  subnets                 = module.ec2.public_subnet_ids
  security_groups         = [module.ec2.app_security_group]
  image                   = var.image_url
  app_port                = var.container_port
  awslog_region           = var.region

  depends_on = [module.ec2]
}
