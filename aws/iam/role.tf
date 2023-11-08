resource "aws_iam_role" "ecsAutoscaleRole" {
  name               = "ecsAutoscaleRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}