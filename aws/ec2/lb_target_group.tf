resource "aws_lb_target_group" "apptg" {
  vpc_id      = aws_vpc.main.id
  name        = "ReactAppLBTargetGroup"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  ip_address_type = "ipv4"
}