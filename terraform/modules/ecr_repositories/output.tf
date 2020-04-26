output "repositories_url" {
  value       = values(aws_ecr_repository.all)[*].repository_url
  description = "List of all repositories"
}

output "repositories_arn" {
  value       = values(aws_ecr_repository.all)[*].arn
  description = "List of all repositories"
}
