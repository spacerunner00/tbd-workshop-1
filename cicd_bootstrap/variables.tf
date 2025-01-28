variable "project_name" {
  type        = string
  description = "Project name"
}

variable "region" {
  type        = string
  default     = "europe-west1"
  description = "GCP region"
}

variable "iac_service_account" {
  type        = string
  default     = "tbd-2024zz-305978-lab@tbd-2024zz-305978.iam.gserviceaccount.com"
  description = "Service account to be used with CI/CD workload identity"
}

variable "github_repo" {
  type        = string
  default     = "tbd-workshop-1"
  description = "Github repository"
}

variable "github_org" {
  type        = string
  default     = "spacerunner00"
  description = "Github organisation"
}
