# Cluster
resource "aws_ecs_cluster" "main" {
  name = var.clusterName
}

# Capacity Providers
resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.main.name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
}