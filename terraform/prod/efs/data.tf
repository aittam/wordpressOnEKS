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

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = {
    bucket         = "wponeks-prod"
    key            = "prod/wponeks/ekscluster.tfstate"
    dynamodb_table = "wponeks-prod"
    region         = local.region
    encrypt        = true
  }
}

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}