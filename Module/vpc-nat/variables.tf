variable "region" {
    type = string
    default = "ap-south-1"
}
variable "vpc_name" {}
variable "vpc_cidr" {}
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "availability_zones" { type = list(string) }
variable "ami" {}
variable "instance_type" {}
variable "key_name" {}
# variable "public_key_path" {}
