resource "aws_instance" "app" {
  ami           = "ami-018ccfb6b4745882a"
  instance_type = "t2.micro"
  user_data = file("${path.module}/cloud-init")
  vpc_security_group_ids = [var.default-security-group]
  key_name = "my-access-key-pair"
  iam_instance_profile = var.app-iam-profile

  tags = {
    Name = var.app-name
  }
}