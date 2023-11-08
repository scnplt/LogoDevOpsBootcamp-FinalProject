resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.applb.arn
  port              = var.public_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apptg.arn
  }
}