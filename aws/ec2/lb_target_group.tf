resource "aws_lb_target_group" "apptg" {
  vpc_id      = aws_vpc.main.id
  name        = var.target_group_name
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  ip_address_type = "ipv4"
}