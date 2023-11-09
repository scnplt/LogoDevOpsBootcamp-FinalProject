# Load balancer target group
resource "aws_lb_target_group" "apptargetgroup" {
  vpc_id          = aws_vpc.main.id
  name            = "apptargetgroup"
  port            = var.containerPort
  protocol        = "HTTP"
  target_type     = "ip"
  ip_address_type = "ipv4"
}