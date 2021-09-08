variable "s3_bucket" { } 
variable "vpc_selected" { default = null}
variable "region" {}
variable "flow_log_name" {
  default = "valtix_log"
}
