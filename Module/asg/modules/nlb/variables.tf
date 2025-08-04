variable "project_name" {
  description = "Project name for naming resources"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for NLB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for NLB"
  type        = string
}

variable "listener_port" {
  description = "Listener port for NLB"
  type        = number
}
