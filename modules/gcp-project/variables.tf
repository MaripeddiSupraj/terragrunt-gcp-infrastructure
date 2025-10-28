variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "project_name" {
  description = "The GCP project name"
  type        = string
}

variable "organization_id" {
  description = "The GCP organization ID"
  type        = string
}

variable "folder_id" {
  description = "The GCP folder ID"
  type        = string
  default     = null
}

variable "billing_account" {
  description = "The billing account ID"
  type        = string
}

variable "enable_apis" {
  description = "List of APIs to enable"
  type        = list(string)
  default     = []
}

variable "additional_apis" {
  description = "Additional APIs to enable"
  type        = list(string)
  default     = []
}

variable "common_labels" {
  description = "Common labels to apply to all resources"
  type        = map(string)
  default     = {}
}