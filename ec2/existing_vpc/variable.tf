variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID to use for EC2"
  type        = string
  default     = "ami-0f58b397bc5c1f2e8"
}
 
variable "vpc_name" {
  default = "terr"
}

variable "subnet_name" {
  default = "terra-suba"
}

variable "availability_zone" {
  description = "Availability zone to launch EC2 in"
  type        = string
  default     = "ap-south-1a"
}

variable "root_storage" {
    description = "default root storage for instance"
    type = number
    default = "10"
}