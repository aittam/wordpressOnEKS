module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name     = local.cluster_name
  cluster_version  = local.cluster_version
  subnets          = data.terraform_remote_state.network.outputs.private_subnets
  write_kubeconfig = false

  tags = {
    Environment = local.environment
  }

  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }

  node_groups = {
    t3large = {
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t3.large"
      k8s_labels = {
        Environment = local.environment
      }
    }
  }
}
