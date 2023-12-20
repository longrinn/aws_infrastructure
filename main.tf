terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~>2.10.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~>2.4"
    }
  }

  backend "s3" {
    bucket = "mddinternship-eks-bucket"
    key = "terraform.tfstate"
    region = "eu-west-1"
    encrypt = true
  }

}

data "aws_eks_cluster" "example" {
  name = "eks-mddinternship-23"
}

data "aws_eks_cluster_auth" "example" {
  name = "eks-mddinternship-23"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.example.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.example.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.example.token
}

provider "aws" {
  region = local.env.region
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  enable_dns_support = true
  enable_dns_hostnames = true

  azs = ["${local.env.region}a", "${local.env.region}b"]
  private_subnets = ["10.0.1.0/24",  "10.0.2.0/24"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  map_public_ip_on_launch = true

  enable_nat_gateway = true
  single_nat_gateway = true

  private_subnet_tags = {
    "kubernetes.io/role/elb-internal" = "1"
    "kubernetes.io/cluster/${local.env.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/${local.env.cluster_name}" = "shared"
  }
}
