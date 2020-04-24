variable "environment" {
  type        = string
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', ..."
}

variable "name" {
  type        = string
  default     = "terraform"
  description = "backend name, it will be used as bucket name and dynamodb table name"
}

variable "region" {
  type        = string
  description = "AWS Region the S3 bucket should reside in"
}

variable "acl" {
  type        = string
  description = "The canned ACL to apply to the S3 bucket"
  default     = "private"
}

variable "read_capacity" {
  type        = number
  default     = 5
  description = "DynamoDB read capacity units"
}

variable "write_capacity" {
  type        = number
  default     = 5
  description = "DynamoDB write capacity units"
}

variable "force_destroy" {
  type        = bool
  description = "A boolean that indicates the S3 bucket can be destroyed even if it contains objects. These objects are not recoverable"
  default     = false
}

variable "mfa_delete" {
  type        = bool
  description = "A boolean that indicates that versions of S3 objects can only be deleted with MFA. ( Terraform cannot apply changes of this value; https://github.com/terraform-providers/terraform-provider-aws/issues/629 )"
  default     = false
}

variable "block_public_acls" {
  type        = bool
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  default     = false
}

variable "ignore_public_acls" {
  type        = bool
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  default     = false
}

variable "block_public_policy" {
  type        = bool
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  default     = false
}

variable "restrict_public_buckets" {
  type        = bool
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  default     = false
}
