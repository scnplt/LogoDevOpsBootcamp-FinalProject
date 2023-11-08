resource "aws_iam_role_policy_attachment" "ecsAutoscaleRole-policy_attachment" {
  role       = aws_iam_role.ecsAutoscaleRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}