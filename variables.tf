variable "name" { }
variable "subnets" { }
variable "source_sgs" { }
variable "vpc_id" { }
variable "instance_type" { default = "cache.t2.micro" }
variable "port" { default = "6379" }
variable "engine" { default = "redis" }
variable "engine_version" { default = "2.8.19" }
variable "parameter_group" { default = "default.redis2.8" }
variable "cache_nodes" { default = "1" }
