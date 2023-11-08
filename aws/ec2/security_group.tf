resource "aws_default_security_group" "default" {
  vpc_id      = aws_vpc.main.id
  ingress = []
  egress  = []
}

resource "aws_security_group" "lb" {
  name        = "ReactAppLBSecurityGroup"
  description = "Load balancer security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app" {
  name        = "app"
  description = "ReactApp security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    security_groups  = [aws_security_group.lb.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
