variable "secret_name" {
  type        = string
  description = "Name of the secret"
}

variable "secret_description" {
  type        = string
  description = "Description for the secret"
}

variable "secret_kv_pairs" {
  type        = map(string)
  description = "Key-value pairs (e.g., username/password)"
}

variable "region" {
  type = string
  description = "using the region for creation of the secret's"
  default = "ap-south-1"
}