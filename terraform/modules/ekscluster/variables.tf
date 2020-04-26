variable "cluster_name" {
  type        = string
  default     = "myk8s"
  description = "cluster name"
}

variable "cluster_version" {
  type        = string
  default     = "1.15"
  description = "cluster version"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "subnets" {
  type        = list(string)
  description = "Subnet IDs"
}

variable "worker_disk_size" {
  type        = number
  default     = 50
  description = "worker disk size in GB"
}

variable "k8s_labels" {
  type        = map(string)
  default     = {}
  description = "node labels"
}

variable "node_group_desired_capacity" {
  type        = number
  default     = 1
  description = "node group asg desired capacity"
}

variable "node_group_min_capacity" {
  type        = number
  default     = 1
  description = "node group asg min capacity"
}

variable "node_group_max_capacity" {
  type        = number
  default     = 3
  description = "node group asg max capacity"
}

variable "node_group_instance_type" {
  type        = string
  default     = "t3.large"
  description = "node group instance type"
}

variable "node_group_name_prefix" {
  type        = string
  default     = "mynodegroup"
  description = "node group name prefix"
}


variable "cluster_log_retention_in_days" {
  type        = number
  default     = 7
}