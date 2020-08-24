resource "aws_ecr_repository" "app-name-registry" {
  name                 = var.fargate-app-name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
