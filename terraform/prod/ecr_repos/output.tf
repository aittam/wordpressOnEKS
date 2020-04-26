output "repositories_url" {
  value       = module.ecr.repositories_url
  description = "List of all repositories"
}

output "repositories_arn" {
  value       = module.ecr.repositories_arn
  description = "List of all repositories"
}
