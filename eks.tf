module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "19.19.0"

  cluster_name = local.env.cluster_name

  subnet_ids = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id

  cluster_endpoint_private_access = false
  cluster_endpoint_public_access = true
  create_cloudwatch_log_group = false

  cluster_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::315727832121:user/daniel.moscalu@endava.com"
      username = "daniel.moscalu@endava.com"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::315727832121:user/ion.caraman@endava.com"
      username = "ion.caraman@endava.com"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::315727832121:user/anna.vicolova@endava.com"
      username = "anna.vicolova@endava.com"
      groups   = ["system:masters"]
    }
  ]

  aws_auth_accounts = [
    "315727832121"
  ]

  eks_managed_node_groups = {
    default = {
      desired_capacity = 2
      max_capacity = 2
      min_capacity = 0

      instance_type = "t3.medium"

      k8s_labels = {
        Environment = "prod"
      }

      additional_tags = {
        Name = "eks-default-node"
      }

      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonEFSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
      }
    }
  }

  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol = "-1"
      from_port = 0
      to_port = 0
      type = "ingress"
      self = true
    }

    egress_all = {
      description = "Node all egress"
      protocol = "-1"
      from_port = 0
      to_port = 0
      type = "egress"
      cidr_blocks = ["0.0.0.0/0"]
      ipv5_cidr_blocks = ["::/0"]
    }
  }
}
