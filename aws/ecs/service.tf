resource "aws_ecs_service" "appservice" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.appservice.arn
  desired_count   = var.desired_count
  launch_type = "FARGATE"
  wait_for_steady_state = true

  load_balancer {
    container_name = "appcontainer"
    target_group_arn = var.target_group_arn
    container_port = var.app_port
  }

  network_configuration {
    subnets = var.subnets
    security_groups = var.security_groups
    assign_public_ip = true
  }
}