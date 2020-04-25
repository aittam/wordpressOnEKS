module "db" {
  source = "../../modules/rds"

  rds_identifier = local.rds_identifier
  # explictly set just for the sake of readiness
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name     = local.db_name
  db_user     = local.db_user
  db_password = local.password #FIXME: replace with secrets manager

  multi_az = true
  tags = {
    Environment = local.environment
  }

  vpc_id  = data.terraform_remote_state.network.outputs.vpc_id
  subnets = data.terraform_remote_state.network.outputs.database_subnets

  ingress_sg_cidr_blocks = data.terraform_remote_state.network.outputs.private_subnets_cidr_blocks

}
