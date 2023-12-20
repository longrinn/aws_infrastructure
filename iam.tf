# resource "aws_iam_role" "eks" {
#   name = "mddinternship-2023-fall"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": ["ec2.amazonaws.com", "eks.amazonaws.com"]
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy_attachment" "eks-attachment" {
#   role       = aws_iam_role.eks.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
# }

# resource "aws_iam_role_policy" "route53-policy" {
#   name   = "route53-policy"
#   role   = aws_iam_role.eks.id
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "Route53CreateDelListAndRead",
#       "Effect": "Allow",
#       "Action": [
#         "route53:CreateHostedZone",
#         "route53:DeleteHostedZone",
#         "route53:ListHostedZones",
#         "route53:AssociateVPCWithHostedZone",
#         "route53:ListResourceRecordSets",
#         "route53:GetHostedZone",
#         "route53:GetChange"
#       ],
#       "Resource": "*"
#     },
#     {
#       "Sid": "Route53ChangeResourceRecordSets",
#       "Effect": "Allow",
#       "Action": "route53:ChangeResourceRecordSets",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy" "s3-policy" {
#   name   = "s3-policy"
#   role   = aws_iam_role.eks.id
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "S3ListAndRead",
#       "Effect": "Allow",
#       "Action": [
#         "s3:ListBucket",
#         "s3:GetBucketLocation",
#         "s3:GetObject"
#       ],
#       "Resource": "*"
#     },
#     {
#       "Sid": "S3PutAndDelete",
#       "Effect": "Allow",
#       "Action": [
#         "s3:PutObject",
#         "s3:DeleteObject"
#       ],
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy" "kms-policy" {
#   name   = "kms-policy"
#   role   = aws_iam_role.eks.id
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "KMSGetCreateDelEdit",
#       "Effect": "Allow",
#       "Action": [
#         "kms:CreateKey",
#         "kms:DeleteKey",
#         "kms:ListKeys"
#       ],
#       "Resource": "*"
#     },
#     {
#       "Sid": "KMSUseKey",
#       "Effect": "Allow",
#       "Action": [
#         "kms:Encrypt",
#         "kms:Decrypt",
#         "kms:ReEncrypt*",
#         "kms:GenerateDataKey*",
#         "kms:DescribeKey"
#       ],
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy" "elb_policy" {
#   name        = "elb_policy"
#   role        = aws_iam_role.eks.id

#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "elasticloadbalancing:DescribeLoadBalancers",
#                 "elasticloadbalancing:CreateLoadBalancer",
#                 "elasticloadbalancing:ModifyLoadBalancerAttributes",
#                 "elasticloadbalancing:DeleteLoadBalancer",
#                 "elasticloadbalancing:RegisterTargets",
#                 "elasticloadbalancing:DeregisterTargets",
#                 "elasticloadbalancing:DescribeTargetGroups",
#                 "elasticloadbalancing:CreateTargetGroup",
#                 "elasticloadbalancing:DeleteTargetGroup",
#                 "autoscaling:DescribeAutoScalingGroups",
#                 "autoscaling:UpdateAutoScalingGroup",
#                 "autoscaling:CreateAutoScalingGroup",
#                 "autoscaling:DeleteAutoScalingGroup",
#                 "autoscaling:CreateLaunchConfiguration",
#                 "autoscaling:DeleteLaunchConfiguration"
#             ],
#             "Resource": "*"
#         }
#     ]
# }
# EOF
# }

# resource "aws_iam_role_policy" "schedule_policy" {
#   name    = "schedule_policy"
#   role    = aws_iam_role.eks.id

#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Action": [
#                 "autoscaling:PutScheduledUpdatdeGroupAction",
#                 "autoscaling:DeleteScheduledAction",
#                 "autoscaling:DescribeScheduledActions",
#                 "autoscaling:CreateScalingProcessTypes",
#                 "autoscaling:DescribeScalingProcessTypes",
#                 "autoscaling:DescribeAutoScalingGroups",
#                 "autoscaling:DescribeTags",
#                 "autoscaling:SuspendProcesses",
#                 "autoscaling:ResumeProcesses",
#                 "autoscaling:UpdateAutoScalingGroup",
#                 "autoscaling:DescribeAutoScalingInstances",
#                 "autoscaling:TerminateInstanceInAutoScalingGroup",
#                 "ec2:TerminateInstances"
#             ],
#             "Resource": "*",
#             "Effect": "Allow"
#         }
#     ]
# }
# EOF
# }
