variable "vpc_id" {
  description = "The ID of the VPC you wish to create the ElastiCache cluster in"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block VPC specified in 'vpc_id' for targeting Security Group rules"
  type        = string
}

variable "name" {
  description = "This will be the name prefix for all resources as well as the value for the 'Name' tag"
  type        = string
  default     = "elasticache"
}

variable "cluster_id" {
  description = "The ElastiCache group identifier"
  type        = string
  default     = "elasticache-group"
}

variable "ami" {
  description = "The default AMI to use for ElastiCache instances"
  type        = string
  default     = "ami-787a320b"
}

variable "subnets" {
  description = "List of VPC Subnet IDs for the cache subnet group"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for ElastiCache instances"
  type        = string
  default     = "cache.m3.medium"
}

variable "port" {
  description = "The port to use for ElastiCache"
  type        = string
  default     = "6379"
}

variable "engine" {
  description = "Name of the cache engine to be used for this cache cluster. Valid values for this variable are memcached or redis"
  type        = string
  default     = "redis"
}

variable "engine_version" {
  description = "Version number of the cache engine to be used"
  type        = string
  default     = "2.8.24"
}

variable "parameter_group" {
  description = "Name of the parameter group to associate with this cache cluster"
  type        = string
  default     = "default.redis2.8"
}

variable "cache_nodes" {
  description = "The initial number of cache nodes that the cache cluster will have"
  type        = string
  default     = 1
}

#TODO -- snapshots not required at the moment
variable "snapshot_window" {
  description = "The daily time range (UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster"
  type        = string
  default     = "03:00-05:00"
}

variable "snapshot_retention_limit" {
  description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them"
  type        = string
  default     = 5
}

variable "maintenance_window" {
  description = "ElastiCache Maintenance Windows"
  type        = string
  default     = "tue:22:00-tue:23:00"
}
