terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.15.0"
    }
  }
}

provider "google" {
  credentials = file(var.tf_runner_gcp_credentials)
  project     = var.project
  region      = var.region
}

variable "roles" {
  type = set(string)

  default = [
    "roles/bigquery.dataEditor",
    "roles/bigquery.jobUser",
    "roles/bigquery.readSessionUser"
  ]
}

resource "google_service_account" "wk2_h2_mage_sa" {
  account_id   = var.wk2_hw_mage_sa_id
  display_name = var.wk2_hw_mage_sa_name
}

# the SA is given data editor access to the bigquery
resource "google_project_iam_member" "bigquery_wk2_mage_sa" {
  project  = var.project
  for_each = var.roles
  role     = each.value
  member   = "serviceAccount:${google_service_account.wk2_h2_mage_sa.email}"
}

# the SA is given an admin access to the specific bucket we will create below
resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.wk2_hw_bucket.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.wk2_h2_mage_sa.email}"

}

resource "google_storage_bucket" "wk2_hw_bucket" {
  name          = "wk2_hw_bucket"
  location      = var.location
  storage_class = "STANDARD"
  force_destroy = true

  public_access_prevention    = "enforced"
  uniform_bucket_level_access = "true"
}
