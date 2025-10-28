output "service_name" {
  description = "Name of the Kubernetes service"
  value       = kubernetes_service.app.metadata[0].name
}

output "namespace" {
  description = "Kubernetes namespace"
  value       = kubernetes_namespace.app.metadata[0].name
}