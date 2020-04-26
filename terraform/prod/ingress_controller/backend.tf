terraform {
  required_version = ">= 0.12, < 0.13"

  backend "s3" {
    bucket         = "wponeks-prod"
    key            = "prod/wponeks/ingresscontroller.tfstate"
    dynamodb_table = "wponeks-prod"
    region         = "eu-west-1"
    encrypt        = true
  }
}
