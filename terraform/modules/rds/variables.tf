variable "ingress_sg_cidr_blocks" {
  type        = list(string)
  description = "CIDRs allowed to connect to the rds"
}

variable "rds_identifier" {
  type        = string
}

variable "engine" {
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  type        = string
  default     = "5.7.19"
}

variable "family" {
  type        = string
  default     = "mysql5.7"
}

variable "major_engine_version" {
  type        = string
  default     = "5.7"
}

variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  type        = number
  default     = 5
}

variable "db_user" {
  type        = string
  default     = "dbuser"
}

variable "db_password" {
  type        = string
}

variable "maintenance_window" {
  type        = string
  default     = "Mon:00:00-Mon:03:00"
}

variable "backup_window" {
  type        = string
  default     = "03:00-06:00"
}

variable "backup_retention_period" {
  type        = number
  default     = 7
}

variable "db_name" {
  type        = string
  default     = "terraform"
  description = "db name"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnets" {
  type        = list(string)
  description = "Subnet IDs"
}

variable "deletion_protection" {
  type        = bool
  description = "If true, prevent rds to be deleted"
  default     = false
}

variable "multi_az" {
  type        = bool
  description = "If true, prevent rds to be deleted"
  default     = false
}
