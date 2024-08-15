#EDIT ONLY THIS

variable "project_id" {
  description = "Change the default value to your project ID before running"
  type        = string
  default     = "titan-sandbox"
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