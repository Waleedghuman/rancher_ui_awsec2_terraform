variable "aws_access_key" {
}
variable "aws_secret_key" {
}
variable "image_id" {
  type    = string
  default = "ami-0fc5d935ebf8bc3bc"
}
variable "machine_type" {
  type    = string
  default = "t3.medium"
}
variable "machine_ports" {
  type = list(number)
}
variable "route53_domain" {
  type    = string
  default = "rancher-ui.awssolutionsprovider.com"
}
variable "local_k3s_version" {
  type    = string
  default = "v1.25.8+k3s1"
}
variable "rancher_server_version" {
  type    = string
  default = "2.7.9"
}
variable "aws_route53_zone" {
  type    = string
  default = "awssolutionsprovider.com"
}
variable "route53_record_type" {
  type    = string
  default = "A"
}

variable "ec2_public_ip" {
  type    = bool
  default = true
}

variable "route53_ttl" {
  type    = number
  default = 300
}