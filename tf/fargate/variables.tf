variable "env" {
  description = "Env Name"
  type        = string
  default     = "dev"
}

variable "fargate-app-name" {
  description = "Application Name"
  type        = string
  default     = "fargate-test-app"
}
