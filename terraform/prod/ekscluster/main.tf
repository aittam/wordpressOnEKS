module "eks" {
  source = "../../modules/ekscluster"

  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version
  subnets         = data.terraform_remote_state.network.outputs.private_subnets
  vpc_id          = data.terraform_remote_state.network.outputs.vpc_id

  workers_additional_policies = local.workers_additional_policies

  # workers specs
  worker_disk_size            = 30
  node_group_desired_capacity = 1
  node_group_min_capacity     = 1
  node_group_max_capacity     = 2
  node_group_instance_type    = "t3.large"
  node_group_name_prefix      = "t3large"

  cluster_log_retention_in_days = 7

  k8s_labels = {
    Environment = local.environment
  }

  tags = {
    Environment = local.environment
  }

}
