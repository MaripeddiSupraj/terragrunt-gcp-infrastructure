variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "instance_name" {
  description = "The name of the Cloud SQL instance"
  type        = string
}

variable "database_version" {
  description = "The database version"
  type        = string
  default     = "POSTGRES_15"
}

variable "region" {
  description = "The region for the instance"
  type        = string
}

variable "tier" {
  description = "The machine tier"
  type        = string
}

variable "disk_size" {
  description = "The disk size in GB"
  type        = number
}

variable "disk_type" {
  description = "The disk type"
  type        = string
  default     = "PD_SSD"
}

variable "availability_type" {
  description = "The availability type"
  type        = string
  default     = "ZONAL"
}

variable "backup_enabled" {
  description = "Enable backups"
  type        = bool
  default     = true
}

variable "backup_start_time" {
  description = "Backup start time"
  type        = string
  default     = "03:00"
}

variable "vpc_network" {
  description = "The VPC network"
  type        = string
}

variable "private_network" {
  description = "The private network connection"
  type        = string
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = true
}

variable "databases" {
  description = "List of databases to create"
  type = list(object({
    name      = string
    charset   = string
    collation = string
  }))
  default = []
}

variable "users" {
  description = "List of users to create"
  type = list(object({
    name     = string
    password = string
  }))
  default = []
}