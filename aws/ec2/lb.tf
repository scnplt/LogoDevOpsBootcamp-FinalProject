resource "aws_lb" "applb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ aws_security_group.lb.id ]
  subnets            = [ aws_subnet.app1.id, aws_subnet.app2.id ]
}