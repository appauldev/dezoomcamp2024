variable "credentials" {
  description = "My Credentials"
  default     = "../keys/gcp-terraform-runner.json"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
}


variable "project" {
  description = "Project"
  default     = "valued-listener-412612"
}

variable "region" {
  description = "Region"
  # DONE Update the below to your desired region
  default = "ASIA"
}

variable "location" {
  description = "Project Location"
  # DONE Update the below to your desired location
  default = "asia-east1"
}

# variable "bq_dataset_name" {
#   description = "My BigQuery Dataset Name"
#   # DONE Update the below to what you want your dataset to be called
#   default = "tf_demo_dataset"
# }

variable "gcs_bucket_name" {
  description = "Storage bucket for Mage orchestration"
  # DONE Update the below to a unique bucket name
  default = "dez2024-mage-bucket-0"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}

variable "mage_sa_name" {
  description = "The name for the Mage Service Account"
  default     = "Mage Service Account"
}

variable "mage_sa_id" {
  description = "The ID for the Mage Service Account"
  default     = "mage-service-acccount"
}
