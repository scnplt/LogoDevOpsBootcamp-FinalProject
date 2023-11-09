resource "aws_vpc" "main" {
  cidr_block       = var.vpcCidrBlock
  instance_tenancy = "default"

  tags = {
    Name = var.vpcName
  }
}