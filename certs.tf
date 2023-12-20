module "cert_manager" {
  source        = "terraform-iaac/cert-manager/kubernetes"

  cluster_issuer_email                   = "daniel.moscalu@endava.com"
  cluster_issuer_name                    = "cert-manager-global"
  cluster_issuer_private_key_secret_name = "cert-manager-private-key"
  depends_on = [ module.eks ]

  solvers = [
    {
    http01 = {
      ingress = {
        class = "ingress-nginx"
      }
    }
  }
 ]
  certificates = {
    "wildcard-tls-secret" = {
      secret_name = "tls-secret"
      dns_names = ["*.app.mddinternship.com"]
    }
  }
}
