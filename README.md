# tf-aws-elasticache

Spins up an ElastiCache cluster (defaults to Redis 2.8.19)

## Usage

```
module "elasticache" {
  source      = "git::ssh://git@gogs.bashton.net:Bashton-Terraform-Modules/tf-aws-elasticache.git"
  name        = "elaticache-cluster"
  subnets     = ["172.16.0.0/24","172.16.0.1/24","172.16.0.2/24"]
  vpc_id      = "vpc-00000000"

}
```

The example will create a single node (t2.micro) Redis cluster running version
2.8.24 using the default Redis 2.8 parameter group. A security group is created
allowing access on the default engine port (default - Redis port 6379). The 
expectation is that access will be via an instance in a VPC security group. 
The cluster is created in asubnet group made up of the `subnets` variable.

## Available Variables
`name` - Name of the cluster  
`subnets` - List of subnets   
`vpc_id` - ID of the VPC to create the cluster in  
`instance_type` - Instance type to use (defaults to t2.micro)  
`port` - Engine port to use (defaults to 6379)  
`engine` - Engine to use `redis` or `memcached` (defaults to Redis)  
`engine_version` - Engine version to use (defaults to 2.8.24)  
`parameter_group` - Parameter group to use (defaults to default.redis2.8)  
`cache_nodes` - Number of cache nodes (defaults to 1 it's only available option
for Redis)
`enabled` - Enable or disable the services with the use of count

## Outputs  
`endpoint` - List of node objects (`id`, `address`, `port`,`az`)  
`node_address` - Node address  
`memcached_endpoint` - Memcached endpoint (not available with Redis engine)  
