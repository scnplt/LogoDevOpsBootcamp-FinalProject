variable "clusterName" { type = string }

variable "containerName" { type = string }
variable "executionRoleArn" { type = string }
variable "imageURL" { type = string }
variable "containerPort" { type = number }

variable "serviceName" { type = string }
variable "desiredCount" { type = number }
variable "lbTargetGroupArn" { type = string }
variable "publicSubnetIDs" { type = list(string) }
variable "appSecurityGroupIDs" { type = list(string) }