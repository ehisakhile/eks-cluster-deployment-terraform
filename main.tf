terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "eks" {
  source ="terraform-aws-modules/eks/aws"

  version = "~> 20.0"
  cluster_name = var.cluster_name
  cluster_version = "1.31"
  cluster_endpoint_public_access = true
  vpc_id = var.vpc-id
  subnet_ids               = var.subnet_ids
  control_plane_subnet_ids = var.control_plane_subnet_ids

   # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t2.medium"]
  }

  eks_managed_node_groups = {
    worker_node = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t2.small"]
      capacity_type = "SPOT"

      min_size     = 1
      max_size     = 2
      desired_size = 1

      subnet_ids = var.worker_node_subnet_id
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true
  authentication_mode = "CONFIG_MAP"

  tags = {
    Environment = "test-lab"
    Terraform   = "true"
  }

}
