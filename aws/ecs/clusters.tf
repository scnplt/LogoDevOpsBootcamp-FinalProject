# Terraform : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster
# Cluster
resource "aws_ecs_cluster" "main" {
  name = var.clusterName

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# Terraform : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster_capacity_providers
# Capacity Providers
resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name       = aws_ecs_cluster.main.name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
}