data "aws_eks_cluster" "eks_cluster" {
  count      = module.eks.cluster_name != null && module.eks.cluster_name != "" ? 1 : 0
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "eks_cluster_auth" {
  count      = module.eks.cluster_name != null && module.eks.cluster_name != "" ? 1 : 0
  name = module.eks.cluster_name
}

# Define the kubeconfig template
locals {
  kubeconfig_yaml = templatefile("${path.module}/kubeconfig.tpl", {
    cluster_name = data.aws_eks_cluster.eks_cluster.name
    endpoint     = data.aws_eks_cluster.eks_cluster.endpoint
    cert_data    = data.aws_eks_cluster.eks_cluster.certificate_authority[0].data
    token        = data.aws_eks_cluster_auth.eks_cluster_auth.token
  })
}

# Write the kubeconfig to a file
resource "local_file" "kubeconfig" {
  content  = local.kubeconfig_yaml
  filename = "${path.module}/kubeconfig.yaml"
}