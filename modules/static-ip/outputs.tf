output "ip_address" {
  description = "The static IP address"
  value       = google_compute_global_address.static_ip.address
}

output "ip_name" {
  description = "The name of the static IP"
  value       = google_compute_global_address.static_ip.name
}