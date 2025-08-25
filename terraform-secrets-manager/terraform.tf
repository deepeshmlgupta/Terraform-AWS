terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.7.0"
    }

    region = var.region
  }

}



# terraform apply -var-file="dev.tfvars"
