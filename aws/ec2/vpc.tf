# Terraform : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
# Virtual Private Cloud
resource "aws_vpc" "main" {
  cidr_block       = var.vpcCidrBlock
  instance_tenancy = "default"

  tags = {
    Name = var.vpcName
  }
}