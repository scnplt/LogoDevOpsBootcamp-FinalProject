resource "aws_security_group" "lb" {
  name        = "LBSecurityGroup"
  description = "Load balancer security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port        = var.public_port
    to_port          = var.public_port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = var.container_port
    to_port          = var.container_port
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_default_security_group" "default" {
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_groups  = [aws_security_group.lb.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}