# Terraform : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# Terraform: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones
# Availability Zones (e.g. us-east-1a, us-east-1b, us-east-1c)
data "aws_availability_zones" "available" {
  state = "available"
}

# Terraform : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
# Subnets
resource "aws_subnet" "public-subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpcCidrBlock, 8, 1)
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "public-subnet1"
  }
}


resource "aws_subnet" "public-subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpcCidrBlock, 8, 2)
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "public-subnet2"
  }
}

# Terraform : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table.html
# Route Table
resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  route {
    cidr_block = aws_vpc.main.cidr_block
    gateway_id = "local"
  }
}

# Terraform : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
# Route Table Association
resource "aws_route_table_association" "public-subnet1" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_default_route_table.main.id
}

resource "aws_route_table_association" "public-subnet2" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_default_route_table.main.id
}