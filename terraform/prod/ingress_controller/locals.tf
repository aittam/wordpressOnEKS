locals {
  region                 = "eu-west-1"
  environment            = "prod"
  iam_policy_name_prefix = "wponeks-${local.environment}"
}
