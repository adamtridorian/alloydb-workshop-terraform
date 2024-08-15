variable "project_id" {
  type          = string
  description   = "Project ID of GCP Project"
}

variable "services_list" {
  type          = set(string)
  description   = "List of API endpoint to be activated"
}