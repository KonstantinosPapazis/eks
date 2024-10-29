output "eks" {
  value = module.eks.cluster_name != "" ? module.eks : null
}