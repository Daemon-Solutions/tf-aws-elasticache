variable "vpc_id" {}
variable "vpc_cidr" {}

variable "name" { default = "" }

variable "cluster_id" { default = "" }

variable "ami" {
	default = "ami-787a320b"
}

variable "subnets" {
  type = "list"
}

variable "instance_type" {
  default = "cache.m3.medium"
}

variable "port" {
  default = "6379"
}

variable "engine" {
  default = "redis"
}

variable "engine_version" {
  default = "2.8.24"
}

variable "parameter_group" {
  default = "default.redis2.8"
}

variable "cache_nodes" {
  default = "1"
}

variable "snapshot_window" {}

variable "snapshot_retention_limit" {}
