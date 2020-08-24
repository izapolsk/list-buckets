output "fargate-app-repo" {
  value = aws_ecr_repository.app-name-registry.repository_url
}