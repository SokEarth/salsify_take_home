terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = "~> 1.13.1"
  
  backend "s3" {
    bucket         = "salsify-state-bucket1"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

# kubernetes & helm providers will be configured after EKS is created (using data resources / local exec),
# so they are declared here but configured later in workflow if needed.
