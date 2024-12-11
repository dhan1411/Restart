output "db_endpoint" {
  value = split(":", aws_db_instance.server_db.endpoint)[0]
}