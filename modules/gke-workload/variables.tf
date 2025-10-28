variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
}

variable "image" {
  description = "Container image"
  type        = string
}

variable "port" {
  description = "Container port"
  type        = number
  default     = 8080
}

variable "replicas" {
  description = "Number of replicas"
  type        = number
  default     = 1
}

variable "resources" {
  description = "Resource limits and requests"
  type = object({
    requests = map(string)
    limits   = map(string)
  })
  default = {
    requests = {
      cpu    = "100m"
      memory = "128Mi"
    }
    limits = {
      cpu    = "500m"
      memory = "512Mi"
    }
  }
}

variable "env_vars" {
  description = "Environment variables"
  type        = map(string)
  default     = {}
}

variable "health_check" {
  description = "Health check configuration"
  type = object({
    path                  = string
    port                  = number
    initial_delay_seconds = number
    period_seconds        = number
  })
  default = {
    path                  = "/health"
    port                  = 8080
    initial_delay_seconds = 30
    period_seconds        = 10
  }
}

variable "service_type" {
  description = "Kubernetes service type"
  type        = string
  default     = "ClusterIP"
}

variable "create_ingress" {
  description = "Create ingress for external access"
  type        = bool
  default     = false
}

variable "static_ip_name" {
  description = "Name of the static IP for ingress"
  type        = string
  default     = ""
}