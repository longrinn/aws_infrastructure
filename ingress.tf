# module "nginx-controller" {
#   source  = "terraform-iaac/nginx-controller/helm"
#   ingress_class_is_default = true
#   namespace = "ingress"
#   additional_set = [
#     {
#       name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
#       value = "nlb"
#       type  = "string"
#     },
#     {
#       name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-cross-zone-load-balancing-enabled"
#       value = "true"
#       type  = "string"
#     }
#   ]
# }

module "eks-ingress-nginx" {
  source  = "lablabs/eks-ingress-nginx/aws"
  version = "1.2.0"
  values = file("${path.module}/ingress-values.yaml")
}
