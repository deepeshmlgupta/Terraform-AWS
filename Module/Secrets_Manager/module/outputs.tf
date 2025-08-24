output "secret_arn" {
  description = "ARN of the secret"
  value       = aws_secretsmanager_secret.this.arn
}

output "db_username" {
  value     = local.secret_data["username"]
  sensitive = true
}

output "db_password" {
  value     = local.secret_data["password"]
  sensitive = true
}
