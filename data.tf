data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}


data "aws_vpc" "selected" {
  filter {
    name   = "state"
    values = ["available"]
  }
}

data "aws_subnets" "vpc_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1f"] # Exclude us-east-1e
  }
}

data "aws_subnet" "all" {
  for_each = toset(data.aws_subnets.vpc_subnets.ids)
  id       = each.value
}

#data "aws_vpcs" "all" {}
#
#data "aws_subnets" "private_new" {
#  filter {
#    name   = "vpc-id"
#    values = [tolist(data.aws_vpcs.all.ids)[0]]
#  }
#
#  filter {
#    name   = "tag:Attributes"
#    values = ["private"]
#  }
#
#  filter {
#    name   = "tag:Name"
#    values = ["*-private-*"]
#  }
#}