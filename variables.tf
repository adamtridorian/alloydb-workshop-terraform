variable "project_id" {
  description = "Change the default value to your project ID before running"
  type        = string
  default     = "adam-sandbox-425004"
}

variable "editor_emails" {
  description = "Emails of editor users"
  type        = list(string)
  default     = []
}

variable "viewer_emails" {
  description = "Emails of viewer users"
  type        = list(string)
  default     = []
}