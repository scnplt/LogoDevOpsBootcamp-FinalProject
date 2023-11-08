resource "aws_subnet" "app1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "ReactApp1"
  }
}

resource "aws_subnet" "app2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.2.0/24"
  availability_zone = "eu-central-1b"

  tags = {
    Name = "ReactApp2"
  }
}