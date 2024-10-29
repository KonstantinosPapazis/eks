#data "aws_eks_cluster" "eks_cluster" {
#  count = module.eks.cluster_name != null && module.eks.cluster_name != "" ? 1 : 0
#  name       = module.eks.cluster_name != null && module.eks.cluster_name != "" ? module.eks.cluster_name : "dummy"
#  #name  = module.eks.cluster_name
#}
#
#data "aws_eks_cluster_auth" "eks_cluster_auth" {
#  count = module.eks.cluster_name != null && module.eks.cluster_name != "" ? 1 : 0
#  name       = module.eks.cluster_name != null && module.eks.cluster_name != "" ? module.eks.cluster_name : "dummy"
# # name  = module.eks.cluster_name
#}
#
## Define the kubeconfig template, using try() to avoid errors if the data source is empty
#locals {
#  kubeconfig_yaml = length(data.aws_eks_cluster.eks_cluster) > 0 ? templatefile("${path.module}/kubeconfig.tpl", {
#    cluster_name = try(data.aws_eks_cluster.eks_cluster[0].name, "")
#    endpoint     = try(data.aws_eks_cluster.eks_cluster[0].endpoint, "")
#    cert_data    = try(data.aws_eks_cluster.eks_cluster[0].certificate_authority[0].data, "")
#    token        = try(data.aws_eks_cluster_auth.eks_cluster_auth[0].token, "")
#  }) : ""
#}
#
## Write the kubeconfig to a file only if kubeconfig_yaml is generated
#resource "local_file" "kubeconfig" {
#  count    = local.kubeconfig_yaml != "" ? 1 : 0
#  content  = local.kubeconfig_yaml
#  filename = "${path.module}/kubeconfig.yaml"
#}


#locals {
#  # Define the kubeconfig template, using the module outputs if they are non-empty
#  kubeconfig_yaml = module.eks.cluster_name != null && module.eks.cluster_name != "" ? templatefile("${path.module}/kubeconfig.tpl", {
#    cluster_name = module.eks.cluster_name
#    endpoint     = module.eks.cluster_endpoint
#    cert_data    = module.eks.cluster_certificate_authority_data
#    token        = "PLACEHOLDER_TOKEN" # Replace with actual authentication logic if needed
#  }) : ""
#}
#
## Write the kubeconfig to a file only if kubeconfig_yaml is generated
#resource "local_file" "kubeconfig" {
#  count    = local.kubeconfig_yaml != "" ? 1 : 0
#  content  = local.kubeconfig_yaml
#  filename = "${path.module}/kubeconfig.yaml"
#}