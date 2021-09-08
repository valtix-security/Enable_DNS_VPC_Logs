provider "aws" {
  region = var.region
}


data "aws_s3_bucket" "valtix_s3" {
  bucket = var.s3_bucket
}

data "aws_vpcs" "all_vpcs" {}

locals {
  vpcs = var.vpc_selected == null ? data.aws_vpcs.all_vpcs.ids : var.vpc_selected
}

resource "aws_flow_log" "example" {
  for_each = local.vpcs
  log_destination      = data.aws_s3_bucket.valtix_s3.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = each.value
  log_format           = "$${account-id} $${action} $${az-id} $${bytes} $${dstaddr} $${dstport} $${end} $${flow-direction} $${instance-id} $${interface-id} $${log-status} $${packets} $${pkt-dst-aws-service} $${pkt-src-aws-service} $${pkt-dstaddr} $${pkt-srcaddr} $${protocol} $${region} $${srcaddr} $${srcport} $${start} $${sublocation-id} $${sublocation-type} $${subnet-id} $${tcp-flags} $${traffic-path} $${type} $${version} $${vpc-id}"
  tags = {
    Name = var.flow_log_name
  }
}




