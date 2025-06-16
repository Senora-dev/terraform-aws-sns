provider "aws" {
  region = "us-east-1"
}

module "sns" {
  source = "../../"

  name         = "my-basic-topic"
  display_name = "My Basic Topic"
} 