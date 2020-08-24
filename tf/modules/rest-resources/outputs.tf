output "http-sg-id" {
  value = aws_security_group.http-ssh.id
}

output "app-iam-profile" {
  value = aws_iam_instance_profile.app-profile.name
}