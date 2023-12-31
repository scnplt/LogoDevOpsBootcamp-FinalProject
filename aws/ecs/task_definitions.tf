# Terraform : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition
# Task Definition
resource "aws_ecs_task_definition" "appservice" {
  family                   = "apptaskdefinition"
  execution_role_arn       = var.executionRoleArn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }

  container_definitions = jsonencode([
    {
      name  = var.containerName
      image = var.imageURL
      cpu   = 0
      portMappings = [
        {
          containerPort = var.containerPort
          hostPort      = var.containerPort
        }
      ]
      essential = true
    }
  ])
}