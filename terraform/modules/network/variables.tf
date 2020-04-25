variable "name" {
  type        = string
  default     = "myvpc"
}

variable "cidr" {
  type        = string
  default     = "192.168.0.0/16"
}

variable "private_subnets" {
  type        = list(string)
  default     = ["192.168.8.0/21", "192.168.16.0/21"]
  description = "CIDRs allowed to connect to the rds"
}

variable "public_subnets" {
  type        = list(string)
  default     = ["192.168.0.0/22", "192.168.4.0/22"]
  description = "CIDRs allowed to connect to the rds"
}

variable "database_subnets" {
  type        = list(string)
  default     = ["192.168.24.0/24", "192.168.25.0/24"]
  description = "CIDRs allowed to connect to the rds"
}

variable "single_nat_gateway" {
  type        = bool
  default     = true
  description = "whether to have only one natgateway or one each AZ"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "private_subnet_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags  on private subnets"
}

variable "public_subnet_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags on public subnets"
}
