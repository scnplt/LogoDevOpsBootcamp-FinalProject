# Terraform : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm
# AWS       : https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/AlarmThatSendsEmail.html
# Metric alarms for scaling in and out
resource "aws_cloudwatch_metric_alarm" "scaleInCPUBelow20" {
  alarm_name          = "ScaleIn"
  comparison_operator = "LessThanOrEqualToThreshold"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  evaluation_periods  = 1
  period              = 30
  statistic           = "Average"
  threshold           = 20
  actions_enabled     = true
  alarm_actions       = [var.scaleInPolicyArn]
  unit                = "Percent"

  dimensions = {
    ClusterName = var.clusterName
    ServiceName = var.serviceName
  }
}

resource "aws_cloudwatch_metric_alarm" "scaleOutCPUAbove50" {
  alarm_name          = "ScaleOut"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  evaluation_periods  = 1
  period              = 30
  statistic           = "Average"
  threshold           = 50
  actions_enabled     = true
  alarm_actions       = [var.scaleOutPolicyArn]
  unit                = "Percent"

  dimensions = {
    ClusterName = var.clusterName
    ServiceName = var.serviceName
  }
}
