terraform {
  backend "s3" {
    bucket         = "terraform-current-state"
    key            = "global/s3/terraform.tfstate"
    region         = "sa-east-1"
    dynamodb_table = "app-state"
    encrypt        = true
  }
}

module "app-supplimentary-resources" {
  source = "vm\/modules/rest-resources"
  app-instance-id = module.app-itself.app-instance-id
}

module "app-itself" {
  source = "vm\/modules/instances"
  default-security-group = module.app-supplimentary-resources.http-sg-id
  app-iam-profile = module.app-supplimentary-resources.app-iam-profile
}

