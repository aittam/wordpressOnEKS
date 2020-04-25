output "arn" {
  value       = aws_efs_file_system.this.arn
  description = "EFS ARN"
}

output "id" {
  value       = aws_efs_file_system.this.id
  description = "EFS ID"
}

output "dns_name" {
  value       = aws_efs_file_system.this.dns_name
  description = "EFS dns name"
}

output "mount_target_dns_names" {
  value       = coalescelist(aws_efs_mount_target.default.*.dns_name, [""])
  description = "List of EFS mount target DNS names"
}

output "mount_target_ids" {
  value       = coalescelist(aws_efs_mount_target.default.*.id, [""])
  description = "List of EFS mount target IDs (one per Availability Zone)"
}

output "security_group_id" {
  value       = aws_security_group.efs.id
  description = "EFS Security Group ID"
}

output "security_group_arn" {
  value       = aws_security_group.efs.arn
  description = "EFS Security Group ARN"
}

output "security_group_name" {
  value       = aws_security_group.efs.name
  description = "EFS Security Group name"
}
