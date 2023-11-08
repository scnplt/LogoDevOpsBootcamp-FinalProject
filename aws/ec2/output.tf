output "lb_target_group_arn" {
  value = aws_lb_target_group.apptg.arn
}

output "public_subnet_ids" {
  value = [aws_subnet.app1.id, aws_subnet.app2.id]
}

output "app_security_group" {
  value = aws_default_security_group.default.id
}