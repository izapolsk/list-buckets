data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "aws-az" {
  state = "available"
}

data "aws_subnet_ids" "subnet_ids" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_subnet" "subnet" {
  count = length(data.aws_subnet_ids.subnet_ids.ids)
  id    = tolist(data.aws_subnet_ids.subnet_ids.ids)[count.index]
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

resource "aws_alb_target_group" "alb_target_group" {
  name = "test-app-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = data.aws_vpc.default.id
  target_type = "ip"
  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "3"
    path = "/"
    unhealthy_threshold = "2"
  }
  tags = {
    Name = "test-app-alb-target-group"
  }
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.test-app-alb.id
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.alb_target_group.id
    type = "forward"
  }
}

resource "aws_alb" "test-app-alb" {
  name               = "test-app-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = data.aws_subnet.subnet.*.id
  security_groups = [aws_security_group.http-ssh.id]
  enable_deletion_protection = false

  tags = {
    Name = "test-app-alb"
  }
}
