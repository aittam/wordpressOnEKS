
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.33.0"

  name                   = local.name
  azs                    = ["eu-west-1a", "eu-west-1b"]
  cidr                   = "192.168.0.0/16"
  private_subnets        = ["192.168.8.0/21", "192.168.16.0/21"]
  public_subnets         = ["192.168.0.0/22", "192.168.4.0/22"]
  database_subnets       = ["192.168.24.0/24", "192.168.25.0/24"]
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
  enable_s3_endpoint     = true

  tags = {
    Environment = local.environment
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
}
