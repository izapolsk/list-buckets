resource "aws_ecs_cluster" "fargate-test-app" {
  name = "fargate_test_app"
}

resource "aws_ecs_task_definition" "fargate-task-definition" {
  requires_compatibilities = ["FARGATE"]
  family = "fargate-task-app"
  network_mode = "awsvpc"
  container_definitions = file("${path.module}/task_definitions/app.json")
  cpu = 512
  memory = 1024
  execution_role_arn = "arn:aws:iam::096079444332:role/ecsTaskExecutionRole"
  task_role_arn = "arn:aws:iam::096079444332:role/ListS3Buckets"
}

resource "aws_ecs_service" "fargate-app-service" {
  name = "fargate-app-service"
  launch_type = "FARGATE"
  task_definition = aws_ecs_task_definition.fargate-task-definition.arn
}