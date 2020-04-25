
module "network" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.33.0"

  name                   = var.name
  azs                    = slice(data.aws_availability_zones.available.names, 0, 2)
  cidr                   = var.cidr
  private_subnets        = var.private_subnets
  public_subnets         = var.public_subnets
  database_subnets       = var.database_subnets
  enable_nat_gateway     = true
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = var.single_nat_gateway ? false : true
  enable_dns_hostnames   = true
  enable_s3_endpoint     = true

  tags = var.tags

  private_subnet_tags = merge (
    {
      "kubernetes.io/cluster/${var.name}" = "shared"
      "kubernetes.io/role/internal-elb"     = 1
    },
    var.private_subnet_tags
  )
  public_subnet_tags = merge(
    {
      "kubernetes.io/cluster/${var.name}" = "shared"
      "kubernetes.io/role/elb"              = 1
    },
    var.public_subnet_tags
  )
}
