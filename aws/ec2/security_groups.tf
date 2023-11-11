# Terraform : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# Load balancer security group
resource "aws_security_group" "loadbalancer" {
  name        = "LBSecurityGroup"
  description = "Load balancer security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = var.publicPort
    to_port     = var.publicPort
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = var.containerPort
    to_port     = var.containerPort
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Application security group
resource "aws_security_group" "app" {
  name        = "AppSecurityGroup"
  description = "Application security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.loadbalancer.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Default security group
resource "aws_default_security_group" "default" {
  vpc_id  = aws_vpc.main.id
  ingress = []
  egress  = []
}