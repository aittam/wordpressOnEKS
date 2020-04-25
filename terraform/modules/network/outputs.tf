output "vpc_arn" {
  value = module.network.vpc_arn
}
output "vpc_id" {
  value = module.network.vpc_id
}
output "vpc_cidr_block" {
  value = module.network.vpc_cidr_block
}
output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = module.network.private_subnets_cidr_blocks
}
output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = module.network.private_subnet_arns
}
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.network.private_subnets
}
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.network.public_subnets
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = module.network.public_subnet_arns
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = module.network.public_subnets_cidr_blocks
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.network.database_subnets
}

output "database_subnet_arns" {
  description = "List of ARNs of database subnets"
  value       = module.network.database_subnet_arns
}

output "database_subnets_cidr_blocks" {
  description = "List of cidr_blocks of database subnets"
  value       = module.network.database_subnets_cidr_blocks
}
