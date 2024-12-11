provider "aws" {
  region = "us-east-1" 
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "msych-devops3-cluster" 
  cluster_version = "1.26"
  subnets         = ["subnet-0abc123"]

  node_groups = {
    example = {
      desired_capacity = 1
      max_capacity     = 1
      min_capacity     = 1

      instance_type = "t3.medium"
    }
  }
}

module "argocd" {
  source  = "terraform-helm-release"
  name    = "argocd"
  chart   = "argo-cd"
  version = "5.1.1"
  namespace = "argocd"

  set {
    name  = "server.ingress.enabled"
    value = "true"
  }

  set {
    name  = "server.ingress.hosts[0]"
    value = "argocd.msych.devops3.test-danit.com"
  }
}