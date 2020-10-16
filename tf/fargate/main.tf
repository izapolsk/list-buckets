terraform {
  backend "s3" {
    bucket         = "terraform-current-state"
    key            = "global/s3/terraform-fargate.tfstate"
    region         = "sa-east-1"
    dynamodb_table = "fargate-app-state"
    encrypt        = true
  }
}

#1. repo
module "fargate-app-repo" {
  source = "./modules/ecr"
  fargate-app-name = var.fargate-app-name
}

#2. image -> manually via docker build/tag
# TODO: ask what would the best way to do that

#3. cluster
#4. ecs service

module "fargate-app-cluster" {
  source = "./modules/ecs"
  http-sg-id = module.fargate-app-alb.http-sg-id
  subnet_ids = module.fargate-app-alb.subnet_ids
  target_group_arn = module.fargate-app-alb.target_group_arn
}

#5. alb
module "fargate-app-alb" {
  source = "./modules/other"
}


# split prod and dev
# TODO: what would be the best way ?