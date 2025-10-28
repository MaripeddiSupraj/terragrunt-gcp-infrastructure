output "vpc_name" {
  description = "The name of the VPC"
  value       = google_compute_network.vpc.name
}

output "vpc_self_link" {
  description = "The self link of the VPC"
  value       = google_compute_network.vpc.self_link
}

output "private_subnet_name" {
  description = "The name of the private subnet"
  value       = [for subnet in google_compute_subnetwork.subnets : subnet.name if can(regex("private", subnet.name))][0]
}

output "pods_range_name" {
  description = "The name of the pods secondary range"
  value       = "gke-pods"
}

output "services_range_name" {
  description = "The name of the services secondary range"
  value       = "gke-services"
}

output "private_vpc_connection" {
  description = "The private VPC connection"
  value       = google_service_networking_connection.private_vpc_connection.network
}