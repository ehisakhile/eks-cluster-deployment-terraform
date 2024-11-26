variable "cluster_name" {
    description = "This is the name of the Cluster"
    type = string
    default = "Ehis-EKS-Test-Lab"
}

variable "region" {
    description = "Region where Infrastructure is deployed"
    type = string
}

variable "vpc-id" {
    description = "The VPC which holds the infrastructure"
    type = string
}

variable "subnet_ids" {
  description = "VPC Subnet IDs"
  type = list(string)
}

variable "control_plane_subnet_ids" {
  description = "VPC Subnet IDs"
  type = list(string)

}

variable "worker_node_subnet_id" {
  description = "Worker Node Subnet ID"
  type = list(string)
  
}