resource "aws_security_group" "allow_private_subnets" {
  name_prefix = "${local.rds_identifier}_rds_from_private"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    cidr_blocks = data.terraform_remote_state.network.outputs.private_subnets_cidr_blocks
  }
}


module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = local.rds_identifier

  engine               = "mysql"
  engine_version       = "5.7.19"
  family               = "mysql5.7"
  major_engine_version = "5.7"
  instance_class       = "db.t3.micro"
  allocated_storage    = 5
  multi_az             = true

  name     = local.db_name
  username = local.db_user
  password = "tempPassword" #FIXME: replace with secrets manager
  port     = "3306"

  vpc_security_group_ids = ["${aws_security_group.allow_private_subnets.id}"]

  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 7

  tags = {
    Environment = local.environment
  }

  subnet_ids = data.terraform_remote_state.network.outputs.database_subnets

  final_snapshot_identifier = local.rds_identifier

  # Should be true in real world
  deletion_protection = false

}
