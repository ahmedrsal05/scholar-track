terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_project_service" "required_apis" {
  for_each = toset([
    "bigquery.googleapis.com",
    "iam.googleapis.com",
    "storage.googleapis.com",
  ])

  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}

resource "google_storage_bucket" "project_bucket" {
  name          = var.bucket_name
  location      = var.location
  force_destroy = var.force_destroy

  depends_on = [google_project_service.required_apis]

  lifecycle_rule {
    condition {
      age = 45
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "warehouse" {
  dataset_id                 = var.dataset_id
  friendly_name              = "Scholar Track warehouse"
  description                = "Student performance staging and analytics tables"
  location                   = var.location
  delete_contents_on_destroy = var.force_destroy

  depends_on = [google_project_service.required_apis]
}
