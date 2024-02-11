variable "tf_runner_gcp_credentials" {
  description = "The credentials for the terraform gcp SA"
  default     = "../../keys/terraform-runner-sa-keys.json"
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


variable "wk2_hw_mage_sa_name" {
  description = "The name for the week 2 homework - Mage SA"
  default     = "Wk2 Homework Mage SA"
}

variable "wk2_hw_mage_sa_id" {
  description = "The ID for the week 2 homework - Mage SA"
  default     = "wk2-hw-mage-sa"
}
