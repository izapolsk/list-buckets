provider "aws" {
  shared_credentials_file = "~/.aws/tf.creds"
  profile                 = "default"
  region = "sa-east-1"
}