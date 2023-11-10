output "scaleInPolicyArn" {
  value = aws_appautoscaling_policy.scaleInPolicy.arn
}

output "scaleOutPolicyArn" {
  value = aws_appautoscaling_policy.scaleOutPolicy.arn
}