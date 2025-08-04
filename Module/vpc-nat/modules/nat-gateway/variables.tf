variable "vpc_name" {}
variable "vpc_id" {}
variable "igw_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "public_subnet_id" {
  description = "One public subnet ID for NAT Gateway"
  type        = string
}
