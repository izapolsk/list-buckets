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
}

#2. image -> manually via docker build/tag

#3. cluster
module "fargate-app-cluster" {
  source = "./modules/ecs"
}

#4. ecs service
# ecs task definition
#alb

#configuration

# split prod and dev