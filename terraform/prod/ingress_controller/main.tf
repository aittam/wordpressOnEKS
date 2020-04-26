
module "ingress" {
  source = "../../modules/alb_ingress_controller"

  iam_policy_name_prefix = local.iam_policy_name_prefix
  oidc_provider_arn      = data.terraform_remote_state.eks.outputs.oidc_provider_arn
  clusterName            = data.terraform_remote_state.eks.outputs.cluster_id
}