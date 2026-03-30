terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project     = "valid-unfolding-485807-q6"
  region      = "us-central1"
}

resource "google_storage_bucket" "project-bucket" {
  # REMOVED "<" and converted to lowercase as per GCP naming conventions
  name          = "ahmed-scholar-track-bucket"
  location      = "US"
  force_destroy = true # Optional: allows deleting bucket even if it contains objects

  lifecycle_rule {
    condition {
      age = 45
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}