# Create a secret (optional, you can skip if it already exists in UI)
resource "aws_secretsmanager_secret" "this" {
  name        = var.secret_name
  description = var.secret_description
}

# Store the secret value (key-value JSON)
resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(var.secret_kv_pairs)
}

# Data source: Retrieve the latest version of the secret
data "aws_secretsmanager_secret" "this" {
  name = var.secret_name
}

data "aws_secretsmanager_secret_version" "this" {
  secret_id = data.aws_secretsmanager_secret.this.id
}

# Decode secret JSON into map
locals {
  secret_data = jsondecode(data.aws_secretsmanager_secret_version.this.secret_string)
}
