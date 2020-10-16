output "http-sg-id" {
  value = aws_security_group.http-ssh.id
}

output "subnet_ids" {
  value = data.aws_subnet.subnet.*.id
}

output "target_group_arn" {
  value = aws_alb_target_group.alb_target_group.arn
}
