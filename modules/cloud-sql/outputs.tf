output "connection_name" {
  description = "The connection name of the instance"
  value       = google_sql_database_instance.main.connection_name
}

output "private_ip_address" {
  description = "The private IP address of the instance"
  value       = google_sql_database_instance.main.private_ip_address
}

output "instance_name" {
  description = "The name of the instance"
  value       = google_sql_database_instance.main.name
}