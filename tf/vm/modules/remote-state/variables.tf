variable "remote_state_bucket" {
  description = "Remote State Bucket name"
  type        = string
  default     = "terraform-current-state"
}

variable "remote_state_dynamodb" {
  description = "Remote State Lock using DynamoDB"
  type        = string
  default     = "app-state"
}