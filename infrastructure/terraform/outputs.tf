output "bucket_name" {
  description = "GCS bucket used by the pipeline"
  value       = google_storage_bucket.project_bucket.name
}

output "dataset_id" {
  description = "BigQuery dataset used by the pipeline"
  value       = google_bigquery_dataset.warehouse.dataset_id
}
