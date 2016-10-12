variable "vpc_id" {}

variable "name" {}

variable "owner" {}

variable "envname" {}

variable "r53_zone_id" {}

variable "domain" {}

variable "subnets" {
  type = "list"
}

variable "source_sgs" {
  type = "list"
}

variable "instance_type" {
  default = "cache.t2.micro"
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

variable "enable_elasticache_cluster" {
  default = "1"
}

variable "enable_replication_group" {
  default = "0"
}

variable "failover_enabled" {
  default = "false"
}

variable "availability_zones" {
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}
