#EDIT ONLY THIS

variable "project_id" {
  description = "Change the default value to your project ID before running"
  type        = string
  default     = "<PROJECT_ID>"
}

variable "editor_emails" {
  description = "Emails of editor users"
  type        = list(string)
  default     = ["user:<EDITOR_EMAILS>"]
}

variable "viewer_emails" {
  description = "Emails of Vertex AI Workbench users"
  type        = list(string)
  default     = ["user:<WORKBENCH_USER_EMAILS>"]
}

locals {
  unique_emails = toset(concat(var.editor_emails, var.viewer_emails))
}