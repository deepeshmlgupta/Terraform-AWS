# Create a secret
resource "aws_secretsmanager_secret" "this" {
  name        = var.secret_name
  description = var.secret_description
}

# Store secret values (JSON)
resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(var.secret_kv_pairs)
}

# Decode JSON into a map (directly from what we created)
locals {
  secret_data = var.secret_kv_pairs
}
