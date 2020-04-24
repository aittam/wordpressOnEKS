
module "terraform_state_backend" {
  source      = "../../modules/terraform_state_backend"
  environment = "prod"
  name        = "wponeks-prod"
  region      = local.region
}

output "s3_bucket_id" {
  value       = module.terraform_state_backend.s3_bucket_id
  description = "S3 bucket ID"
}

output "dynamodb_table_name" {
  value       = module.terraform_state_backend.dynamodb_table_name
  description = "DynamoDB table name"
}
