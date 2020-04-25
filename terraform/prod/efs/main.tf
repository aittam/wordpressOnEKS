module "efs" {
  source  = "../../modules/efs"
  name    = local.name
  vpc_id  = data.terraform_remote_state.network.outputs.vpc_id
  subnets = data.terraform_remote_state.network.outputs.private_subnets

  ingress_sg_cidr_blocks = data.terraform_remote_state.network.outputs.private_subnets_cidr_blocks

  tags = {
    Environment = local.environment
  }

}
