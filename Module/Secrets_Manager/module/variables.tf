variable "secret_name" {
  description = "The name of the secret in Secrets Manager"
  type        = string
}

variable "secret_description" {
  description = "Description for the secret"
  type        = string
  default     = "Managed by Terraform"
}

variable "secret_kv_pairs" {
  description = "Key-value pairs for the secret (e.g., username/password)"
  type        = map(string)
}
