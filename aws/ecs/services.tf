# Terraform : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_service
# Service definition
resource "aws_ecs_service" "appservice" {
  name                = var.serviceName
  cluster             = aws_ecs_cluster.main.id
  task_definition     = aws_ecs_task_definition.appservice.arn
  desired_count       = var.desiredCount
  scheduling_strategy = "REPLICA"
  launch_type         = "FARGATE"

  load_balancer {
    target_group_arn = var.lbTargetGroupArn
    container_name   = var.containerName
    container_port   = var.containerPort
  }

  network_configuration {
    subnets          = var.publicSubnetIDs
    security_groups  = var.appSecurityGroupIDs
    assign_public_ip = true
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}