data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "http-ssh" {
  name        = "http-ssh"
  description = "Allow HTTP and SSH traffic to app"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "http-ssh"
  }
}

resource "aws_elb" "test-app-elb" {
  name               = "test-app-elb"
  availability_zones = ["sa-east-1a", "sa-east-1c"]
  security_groups = [aws_security_group.http-ssh.id]
  instances = [var.app-instance-id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    target = "HTTP:80/"
    interval = 10
  }

  tags = {
    Name = "test-app-elb"
  }
}
