module "db_secret" {
  source = "./module"

  secret_name        = var.secret_name
  secret_description = var.secret_description
  secret_kv_pairs    = var.secret_kv_pairs
}

# Example: use in RDS
resource "aws_db_instance" "mydb" {
  identifier        = "mydb"
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  username = module.db_secret.db_username
  password = module.db_secret.db_password

  skip_final_snapshot = true
}
