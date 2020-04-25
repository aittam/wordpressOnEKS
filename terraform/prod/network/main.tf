
module "vpc" {
  source = "../../modules/network"

  name               = local.name
  cidr               = "192.168.0.0/16"
  private_subnets    = ["192.168.8.0/21", "192.168.16.0/21"]
  public_subnets     = ["192.168.0.0/22", "192.168.4.0/22"]
  database_subnets   = ["192.168.24.0/24", "192.168.25.0/24"]
  single_nat_gateway = false

  tags = {
    Environment = local.environment
  }

}
