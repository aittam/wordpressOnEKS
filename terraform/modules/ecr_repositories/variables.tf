variable "repositories" {
  type = map(object({
    name = string
    tags = map(string)
  }))
  description = "List of ECR repositories"
}
