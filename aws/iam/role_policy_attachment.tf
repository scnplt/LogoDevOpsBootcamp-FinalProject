resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole-PolicyAttach" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "ecsAutoscaleRole-PolicyAttach" {
  role       = aws_iam_role.ecsAutoscaleRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}