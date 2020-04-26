
resource "aws_ecr_repository" "all" {
  for_each = var.repositories

  name = each.value["name"]
  tags = each.value["tags"]
}