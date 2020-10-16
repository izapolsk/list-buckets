variable "http-sg-id" {
  description = "Security Group for AWS Service"
  type        = string
}

variable "subnet_ids" {
  description = "Available Subnets"
  type        = list(string)
}

variable "target_group_arn" {
  description = "Target Group ARN"
  type        = string
}