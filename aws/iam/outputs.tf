output "ecsTaskExecutionRoleArn" {
  value = aws_iam_role.ecsTaskExecutionRole.arn
}

output "ecsAutoscaleRoleArn" {
  value = aws_iam_role.ecsAutoscaleRole.arn
}