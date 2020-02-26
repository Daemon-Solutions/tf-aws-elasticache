# tf-aws-elasticache

Spins up an ElastiCache cluster (defaults to Redis 2.8.19)

## Terraform version compatibility

| Module version    | Terraform version |
|-------------------|-------------------|
| 1.x.x             | 0.12.x            |
| 0.x.x             | 0.11.x            |

Upgrading from 0.11.x and earlier to 0.12.x should be seamless.  You can simply update the `ref` in your `source` to point to a version greater than `4.0.0`.

When first applied in 0.12.x, some policies may update due to the slight difference in format that occurs when moving from inline JSON to `aws_iam_policy_document`, however the policy permissions granted remain the same.

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
`vpc_cidr` - The VPC CIDR. Used to create a security group granting access to the whole VPC CIDR unless source_sgs is specified.
`source_sgs` - A list of security group ids to allow connections from to the Elasticache. If this is not specified the whole VPC CIDR will be granted access.
`instance_type` - Instance type to use (defaults to t2.micro)  
`port` - Engine port to use (defaults to 6379)  
`engine` - Engine to use `redis` or `memcached` (defaults to Redis)  
`engine_version` - Engine version to use (defaults to 2.8.24)  
`parameter_group` - Parameter group to use (defaults to default.redis2.8)  
`cache_nodes` - Number of cache nodes (defaults to 1 it's only available option
for Redis)

## Outputs
`endpoint` - List of node objects (`id`, `address`, `port`,`az`)
`node_address` - Node address
`memcached_endpoint` - Memcached endpoint (not available with Redis engine)
`security_group_id` - The security group ID for the Elasticache instance.
