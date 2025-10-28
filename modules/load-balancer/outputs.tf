output "external_ip" {
  description = "External IP address of the load balancer"
  value       = google_compute_global_address.default.address
}

output "url" {
  description = "URL to access the application"
  value       = "http://${google_compute_global_address.default.address}"
}