module "eks" {
  #source  = "../k8s-module"
  source = "git::https://github.com/KonstantinosPapazis/k8s-module.git"
  #source = "git::https://github.com/KonstantinosPapazis/k8s-module.git?ref=v1.0.0"
  #version = "~> 20.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.30"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id                   = "vpc-0892ffd96622d719f"
  subnet_ids               = ["subnet-0777df0778d39f450", "subnet-04838a3d822d7c4cb", "subnet-0697c82dad7ac77e7"]
  control_plane_subnet_ids = ["subnet-0777df0778d39f450", "subnet-04838a3d822d7c4cb", "subnet-0697c82dad7ac77e7"]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    example = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 2
      max_size     = 3
      desired_size = 2
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

#  access_entries = {
#    # One access entry with a policy associated
#    example = {
#      kubernetes_groups = []
#      principal_arn     = "arn:aws:iam::123456789012:role/something"
#
#      policy_associations = {
#        example = {
#          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
#          access_scope = {
#            namespaces = ["default"]
#            type       = "namespace"
#          }
#        }
#      }
#    }
#  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}