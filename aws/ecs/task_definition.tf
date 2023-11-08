resource "aws_ecs_task_definition" "appservice" {
  family                   = "AppTaskDefinition"
  execution_role_arn       = var.task_execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "3072"

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }

  container_definitions = <<TASK_DEFINITION
  [
    {
      "name": "appcontainer",
      "image": "${var.image}",
      "cpu": 0,
      "portMappings": [
        {
          "name": "container-${var.app_port}-tcp",
          "containerPort": ${var.app_port},
          "hostPort": ${var.app_port},
          "protocol": "tcp",
          "appProtocol": "http"
        }
      ],
      "essential": true,
      "environment": [],
      "environmentFiles": [],
      "mountPoints": [],
      "volumesFrom": [],
      "ulimits": [],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-create-group": "true",
          "awslogs-group": "/ecs/AppTaskDefinition",
          "awslogs-region": "${var.awslog_region}",
          "awslogs-stream-prefix": "ecs"
        },
        "secretOptions": []
      }
    }
  ]
  TASK_DEFINITION
}
