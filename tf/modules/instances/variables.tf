variable "app-name" {
  description = "Application Name"
  type        = string
  default     = "app"
}

variable "default-security-group" {
  description = "Security group for app"
  type        = string
}

variable "app-iam-profile" {
  description = "IAM profile for app"
  type        = string
}