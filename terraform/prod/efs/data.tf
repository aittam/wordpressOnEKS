data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket         = "wponeks-prod"
    key            = "prod/wponeks/vpc.tfstate"
    dynamodb_table = "wponeks-prod"
    region         = local.region
    encrypt        = true
  }
}
