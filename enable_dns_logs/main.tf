provider "aws" {
  region = var.region
}

data "aws_vpcs" "all_vpcs" {}

locals {
  vpcs = var.vpc_selected == null ? data.aws_vpcs.all_vpcs.ids : var.vpc_selected 
}

resource "aws_route53_resolver_query_log_config_association" "selected_vpc" {
  for_each = local.vpcs
  resource_id = each.value
  resolver_query_log_config_id = var.query_log_config_id
}




