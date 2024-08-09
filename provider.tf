provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAZI2LERTTL3FXEEGD"
  secret_key = "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"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"  
    }
  }
}
