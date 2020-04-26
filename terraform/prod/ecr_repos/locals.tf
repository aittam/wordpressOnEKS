locals {
  region      = "eu-west-1"
  environment = "prod"
  repositories = {
    repo1 = {
      name = "wponeks-${local.environment}-wordpress"
      tags = {
        Environment = local.environment
      }
    }
  }
}
