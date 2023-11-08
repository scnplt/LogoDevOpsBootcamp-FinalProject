resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.main.name
  capacity_providers = ["FARGATE"]
}