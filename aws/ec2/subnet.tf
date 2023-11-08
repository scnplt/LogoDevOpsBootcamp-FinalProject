resource "aws_subnet" "app1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_confs[0].cidr_block
  availability_zone = var.subnet_confs[0].availability_zone
}

resource "aws_subnet" "app2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_confs[1].cidr_block
  availability_zone = var.subnet_confs[1].availability_zone
}