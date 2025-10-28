variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "List of subnets to create"
  type = list(object({
    name                     = string
    cidr                     = string
    region                   = string
    private_ip_google_access = bool
  }))
}

variable "secondary_ranges" {
  description = "Secondary IP ranges for subnets"
  type = map(list(object({
    range_name    = string
    ip_cidr_range = string
  })))
  default = {}
}

variable "firewall_rules" {
  description = "List of firewall rules"
  type = list(object({
    name      = string
    direction = string
    allow = list(object({
      protocol = string
      ports    = optional(list(string))
    }))
    source_ranges = optional(list(string))
    target_tags   = optional(list(string))
  }))
  default = []
}

variable "enable_flow_logs" {
  description = "Enable VPC flow logs"
  type        = bool
  default     = false
}