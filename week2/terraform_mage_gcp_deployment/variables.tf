variable "credentials" {
  description = "My Credentials"
  default     = "./keys/gcp-credentials.json"
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


variable "mage_deploymment_sa_name" {
  description = "The name for the Mage deployment SA"
  default     = "Mage Deployment SA"
}

variable "mage_deployment_sa_id" {
  description = "The ID for the Mage deployment SA"
  default     = "mage-deployment-sa"
}
