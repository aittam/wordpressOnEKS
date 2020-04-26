module "ecr" {
  source = "../../modules/ecr_repositories"

  repositories = local.repositories

}
