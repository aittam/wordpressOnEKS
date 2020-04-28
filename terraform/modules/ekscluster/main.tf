module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "11.1.0"

  cluster_name     = var.cluster_name
  cluster_version  = var.cluster_version
  subnets          = var.subnets
  write_kubeconfig = false
  enable_irsa      = true

  tags = var.tags

  vpc_id = var.vpc_id

  workers_additional_policies = var.workers_additional_policies

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = var.worker_disk_size
  }

  node_groups = {
    for subnet in var.subnets:
      "${var.node_group_name_prefix}_${index(var.subnets, subnet)}" => {
        desired_capacity = var.node_group_desired_capacity
        max_capacity     = var.node_group_max_capacity
        min_capacity     = var.node_group_min_capacity
        instance_type    = var.node_group_instance_type
        subnets          = [subnet]
        k8s_labels       = var.k8s_labels
    }
  }

  cluster_log_retention_in_days = var.cluster_log_retention_in_days
  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]
}
