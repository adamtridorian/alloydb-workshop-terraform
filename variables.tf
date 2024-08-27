#EDIT ONLY THIS

variable "project_id" {
  description = "Change the default value to your project ID before running"
  type        = string
  default     = "adam-sandbox-425004"
}

variable "editor_emails" {
  description = "Emails of editor users"
  type        = list(string)
  default     = ["user:adamboonchaya@gmail.com"]
}

variable "viewer_emails" {
  description = "Emails of viewer users"
  type        = list(string)
  default     = ["user:adamboonchaya@gmail.com"]
}

locals {
  unique_emails = toset(concat(var.editor_emails, var.viewer_emails))
}