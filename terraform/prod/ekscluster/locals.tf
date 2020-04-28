locals {
  region          = "eu-west-1"
  environment     = "prod"
  cluster_name    = "wponeks-${local.environment}"
  cluster_version = "1.15"
  workers_additional_policies = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
    ]

}
