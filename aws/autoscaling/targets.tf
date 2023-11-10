resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.maxCapacity
  min_capacity       = var.minCapacity
  resource_id        = "service/${var.clusterName}/${var.serviceName}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}