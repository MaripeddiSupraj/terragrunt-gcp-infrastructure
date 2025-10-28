variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "region" {
  description = "The region for the GKE cluster"
  type        = string
}

variable "zones" {
  description = "The zones for the GKE cluster"
  type        = list(string)
}

variable "vpc_name" {
  description = "The VPC network name"
  type        = string
}

variable "subnet_name" {
  description = "The subnet name"
  type        = string
}

variable "pods_range_name" {
  description = "The secondary range name for pods"
  type        = string
}

variable "services_range_name" {
  description = "The secondary range name for services"
  type        = string
}

variable "node_pools" {
  description = "List of node pools"
  type = list(object({
    name               = string
    machine_type       = string
    min_count          = number
    max_count          = number
    initial_node_count = number
    disk_size_gb       = number
    disk_type          = string
    preemptible        = bool
    auto_upgrade       = bool
    auto_repair        = bool
  }))
}

variable "enable_private_nodes" {
  description = "Enable private nodes"
  type        = bool
  default     = true
}

variable "master_ipv4_cidr_block" {
  description = "The IP range for the master nodes"
  type        = string
  default     = "172.16.0.0/28"
}

variable "enable_network_policy" {
  description = "Enable network policy"
  type        = bool
  default     = false
}

variable "enable_monitoring" {
  description = "Enable monitoring"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "Enable logging"
  type        = bool
  default     = true
}