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

variable "roles" {
  type = set(string)
  default = [
    "roles/artifactregistry.reader",
    "roles/artifactregistry.writer",
    "roles/run.developer",
    "roles/cloudsql.admin",
    "roles/iam.serviceAccountTokenCreator"
  ]

}

resource "google_service_account" "mage_deployment_sa" {
  account_id   = var.mage_deployment_sa_id
  display_name = var.mage_deploymment_sa_name
}


resource "google_project_iam_member" "mage_deployment" {
  project  = var.project
  for_each = var.roles
  role     = each.value
  member   = "serviceAccount:${google_service_account.mage_deployment_sa.email}"

}
