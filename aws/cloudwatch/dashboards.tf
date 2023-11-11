# Terraform : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_dashboard
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = var.dashboardName

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "alarm"
        x      = 21
        y      = 0
        width  = 3
        height = 3
        properties = {
          title = "Auto Scaling Alarms"
          alarms = [
            aws_cloudwatch_metric_alarm.scaleInCPUBelow20.arn,
            aws_cloudwatch_metric_alarm.scaleOutCPUAbove50.arn
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 7
        height = 7
        properties = {
          title = "Cluster Metrics"
          metrics = [
            ["ECS/ContainerInsights", "ServiceCount", "ClusterName", var.clusterName],
            [".", "TaskCount", ".", "."],
            [".", "MemoryReserved", ".", "."],
            [".", "MemoryUtilized", ".", "."],
            [".", "CpuReserved", ".", "."],
            [".", "CpuUtilized", ".", "."]
          ]
          view                     = "singleValue"
          region                   = var.region
          stat                     = "Average"
          period                   = var.dashboardPeriod
          setPeriodToTimeRange     = true
          singleValueFullPrecision = false
          sparkline                = false
          trendline                = false
          liveData                 = true
        }
      },
      {
        type   = "metric"
        x      = 10
        y      = 7
        width  = 9
        height = 3
        properties = {
          title = "Service"
          metrics = [
            ["ECS/ContainerInsights", "RunningTaskCount", "ServiceName", var.serviceName, "ClusterName", var.clusterName, { "region" : var.region }],
            [".", "PendingTaskCount", ".", ".", ".", ".", { "region" : var.region, "stat" : "Sum" }],
            [".", "DesiredTaskCount", ".", ".", ".", ".", { "region" : var.region }]
          ]
          view   = "singleValue"
          region = var.region
          stat   = "SampleCount"
          period = var.dashboardPeriod
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 7
        width  = 9
        height = 3
        properties = {
          title = "Load Balancer"
          metrics = [
            ["AWS/ApplicationELB", "ActiveConnectionCount", "LoadBalancer", var.loadBalancerArnSuffix, { "region" : var.region }],
            [".", "RequestCount", ".", ".", { "region" : var.region }],
            [".", "TargetResponseTime", ".", ".", { "region" : var.region, "stat" : "Average" }]
          ]
          view                     = "singleValue"
          stacked                  = false
          region                   = var.region
          stat                     = "SampleCount"
          period                   = var.dashboardPeriod
          setPeriodToTimeRange     = true
          trend                    = false
          singleValueFullPrecision = false
          liveData                 = true
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 10
        width  = 9
        height = 5
        properties = {
          title = "HTTP Codes"
          metrics = [
            ["AWS/ApplicationELB", "HTTPCode_Target_2XX_Count", "LoadBalancer", var.loadBalancerArnSuffix, { "region" : var.region }],
            [".", "HTTPCode_Target_3XX_Count", ".", ".", { "region" : var.region }],
            [".", "HTTPCode_Target_4XX_Count", ".", ".", { "region" : var.region }]
          ]
          view                 = "bar"
          stacked              = false
          region               = var.region
          setPeriodToTimeRange = true
          yAxis                = { right = { showUnits = true } }
          stat                 = "SampleCount"
          period               = var.dashboardPeriod
        }
      },
      {
        type   = "metric"
        x      = 13
        y      = 0
        width  = 6
        height = 7
        properties = {
          title = "Cluster Memory"
          metrics = [
            ["ECS/ContainerInsights", "MemoryReserved", "ClusterName", var.clusterName],
            [".", "MemoryUtilized", ".", "."]
          ]
          view                 = "timeSeries"
          region               = var.region
          setPeriodToTimeRange = true
          period               = var.dashboardPeriod
          stat                 = "Average"
          stacked              = false
        }
      },
      {
        type   = "metric"
        x      = 7
        y      = 0
        width  = 6
        height = 7
        properties = {
          title = "Cluster CPU"
          metrics = [
            ["ECS/ContainerInsights", "CpuUtilized", "ClusterName", var.clusterName],
            [".", "CpuReserved", ".", "."]
          ]
          view                 = "timeSeries"
          region               = var.region
          setPeriodToTimeRange = true
          period               = var.dashboardPeriod
          stat                 = "Average"
          stacked              = false
        }
      }
    ]
  })
}
