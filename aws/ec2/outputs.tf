output "publicSubnetIDs" {
  value = [aws_subnet.public-subnet1.id, aws_subnet.public-subnet2.id]
}

output "lbTargetGroupArn" {
  value = aws_lb_target_group.apptargetgroup.arn
}

output "appSecurityGroupIDs" {
  value = [aws_security_group.app.id]
}

output "loadBalancerArnSuffix" {
  value = aws_lb.apploadbalancer.arn_suffix
}