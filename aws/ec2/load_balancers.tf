# Load balancer
resource "aws_lb" "apploadbalancer" {
  name               = "apploadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ aws_security_group.loadbalancer.id ]
  subnets            = [ aws_subnet.public-subnet1.id, aws_subnet.public-subnet2.id ]
}

# Load balancer listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.apploadbalancer.arn
  port              = var.publicPort
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apptargetgroup.arn
  }
}