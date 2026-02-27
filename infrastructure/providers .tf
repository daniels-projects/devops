# Configure the AWS Provider
# Resources that will be managed will default to the Region declared here in the provider configuration.

provider "aws" {
    region = var.aws_region
}
