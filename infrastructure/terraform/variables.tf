variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "Default Google Cloud region"
  type        = string
  default     = "us-central1"
}

variable "location" {
  description = "Location shared by GCS and BigQuery"
  type        = string
  default     = "US"
}

variable "bucket_name" {
  description = "Globally unique GCS bucket name"
  type        = string
}

variable "dataset_id" {
  description = "BigQuery dataset name"
  type        = string
  default     = "scholartrack_warehouse"
}

variable "force_destroy" {
  description = "Allow Terraform to delete non-empty project resources"
  type        = bool
  default     = false
}
