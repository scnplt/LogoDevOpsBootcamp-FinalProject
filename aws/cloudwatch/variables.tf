variable "clusterName" { type = string }
variable "serviceName" { type = string }
variable "scaleInPolicyArn" { type = string }
variable "scaleOutPolicyArn" { type = string }

variable "dashboardName" { type = string }
variable "region" { type = string }
variable "dashboardPeriod" { type = number }
variable "loadBalancerArnSuffix" { type = string }