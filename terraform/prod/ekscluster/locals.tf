locals {
  region          = "eu-west-1"
  environment     = "prod"
  cluster_name    = "wponeks-${local.environment}"
  cluster_version = "1.15"
}
