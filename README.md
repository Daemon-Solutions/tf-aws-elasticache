# tf-aws-elasticache

Spins up an ElastiCache cluster (defaults to Redis 2.8.19)

## Usage

```
module "elasticache" {
  source = "git::ssh://git@gogs.bashton.net:Bashton-Terraform-Modules/tf-aws-elasticache.git"
  count  = "${var.enable_elasticache_cluster}"

  name        = "elaticache-cluster"
  subnets     = ["172.16.0.0/24","172.16.0.1/24","172.16.0.2/24"]
  source_sgs  = ["sg-00000000"]
  vpc_id      = "vpc-00000000"
}
```

```
resource "aws_elasticache_replication_group" "elasticache_rep_group" {
  count = "${var.enable_replication_group}"

  replication_group_id          = "${var.envname}-elasticache"
  replication_group_description = "Elasticache for ${var.envname}"
  node_type                     = "${var.instance_type}"
  number_cache_clusters         = "${var.cache_nodes}"
  port                          = "${var.port}"
  parameter_group_name          = "${var.parameter_group}"
  subnet_group_name             = "${aws_elasticache_subnet_group.main.name}"
  availability_zones            = ["${var.availability_zones}"]
  automatic_failover_enabled    = "${var.failover_enabled}"
  security_group_ids            = ["${aws_security_group.elasticache.id}"]

  tags {
    Name    = "${var.name}"
    owner   = "${var.owner}"
    envname = "${var.envname}"
  }
}
```

The example will create a single node (t2.micro) Redis cluster running version
2.8.24 using the default Redis 2.8 parameter group. A security group is created
allowing access on the default engine port (default - Redis port 6379) from the
security groups passed in under `source_sgs`. The expectation is that access
will be via an instance in a VPC security group. The cluster is created in a
subnet group made up of the `subnets` variable.

## Shared variables
* `cache_nodes` - Number of cache nodes (defaults to 1 it's only available option
  for Redis)
* `domain` - domain name for CNAMEs FQDN
* `envname` - environment name for tagging and naming resources
* `instance_type` - Instance type to use (defaults to t2.micro)
* `name` - Name of the cluster
* `owner` - value of the `owner` tag
* `parameter_group` - Parameter group to use (defaults to default.redis2.8)
* `port` - Engine port to use (defaults to 6379)
* `r53_zone_id` - Route53 zone id to create CNAME in for the endpoint
* `source_sgs` - List of security groups to access the cluster
* `subnets` - List of subnets for creating subnet group
* `vpc_id` - ID of the VPC to create the cluster in


## Variables only for cache cluster
* `enable_elasticache_cluster` - 0|1 (default: 0)
* `engine` - Engine to use `redis` or `memcached` (defaults to Redis)
* `engine_version` - Engine version to use (defaults to 2.8.24)

## Variables only for replication group
* `availability_zones` - count of those have to match `cache_nodes`
* `enable_replication_group` - 0|1 (default: 0)
* `failover_enabled` - only for multi AZ setup

## Outputs
* `cluster_endpoint` - List of node objects (`id`, `address`, `port`,`az`)
* `node_address` - Node address
* `memcached_endpoint` - Memcached endpoint (not available with Redis engine)
* `replication_group_endpoint`
