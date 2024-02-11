terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.15.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}

resource "google_service_account" "mage_service_account" {
  account_id   = var.mage_sa_id
  display_name = var.mage_sa_name
}

resource "google_project_iam_member" "bigquery_admin" {
  project = var.project
  role    = "roles/bigquery.admin"
  member  = "serviceAccount:${google_service_account.mage_service_account.email}"
}

resource "google_project_iam_member" "storage_admin" {
  project = var.project
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.mage_service_account.email}"
}

resource "google_storage_bucket" "mage-bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  storage_class = var.gcs_storage_class
  force_destroy = true

  public_access_prevention    = "enforced"
  uniform_bucket_level_access = "true"

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}



# resource "google_bigquery_dataset" "demo_dataset" {
#   dataset_id = var.bq_dataset_name
#   location   = var.location
# }
