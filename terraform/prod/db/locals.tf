locals {
  region         = "eu-west-1"
  environment    = "prod"
  db_name        = "wponeks"
  rds_identifier = "wponeks-${local.environment}"
  db_user        = "rdsuser"
  password       = "tempPassword"
}
