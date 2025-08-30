# Terraform 설정
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS Provider 설정
provider "aws" {
  region = var.aws_region
}

# Ubuntu 20.04 LTS AMI (서울 리전)
locals {
  ubuntu_ami_id = "ami-0f8d552e06067b477"  # Ubuntu 20.04 LTS
}

# 키 페어 생성
resource "aws_key_pair" "wonderwander_dev" {
  key_name   = "wonderwander-dev-key"
  public_key = file("~/.ssh/wonderwander-dev.pub")

  tags = {
    Name        = "WonderWander Dev Key"
    Environment = "development"
    Project     = "wonderwander"
  }
}