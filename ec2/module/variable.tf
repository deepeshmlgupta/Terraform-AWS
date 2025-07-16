variable "aws_instance_type" {
    default = "t2.micro"
    type = string
}

variable "aws_root_storage" {
  default = 15
  type = number
}

variable "ami_id" {
    default = "ami-0f918f7e67a3323f0"
}