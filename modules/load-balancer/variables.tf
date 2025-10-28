variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "name" {
  description = "Name prefix for load balancer resources"
  type        = string
}

variable "backend_service" {
  description = "Backend service group"
  type        = string
}

variable "health_check_port" {
  description = "Port for health checks"
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "Path for health checks"
  type        = string
  default     = "/"
}

variable "enable_ssl" {
  description = "Enable SSL certificate"
  type        = bool
  default     = false
}

variable "domains" {
  description = "Domains for SSL certificate"
  type        = list(string)
  default     = []
}