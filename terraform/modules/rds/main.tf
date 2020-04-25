resource "aws_security_group" "allow_private_subnets" {
  name_prefix = var.rds_identifier
  vpc_id      = var.vpc_id

  ingress {
    from_port = local.port
    to_port   = local.port
    protocol  = "tcp"

    cidr_blocks = var.ingress_sg_cidr_blocks
  }
}


module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.14"

  identifier = var.rds_identifier

  engine               = var.engine
  engine_version       = var.engine_version
  family               = var.family
  major_engine_version = var.major_engine_version
  instance_class       = var.instance_class
  allocated_storage    = var.allocated_storage
  multi_az             = var.multi_az

  name     = var.db_name
  username = var.db_user
  password = var.db_password
  port     = local.port

  vpc_security_group_ids = ["${aws_security_group.allow_private_subnets.id}"]

  maintenance_window      = var.maintenance_window
  backup_window           = var.backup_window
  backup_retention_period = var.backup_retention_period

  tags = var.tags

  subnet_ids = var.subnets

  final_snapshot_identifier = "${var.rds_identifier}-finalsnapshot"

  deletion_protection = var.deletion_protection

}
