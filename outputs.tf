output "endpoint" {
  value = aws_elasticache_cluster.elasticache.cache_nodes
}

output "node_address" {
  value = aws_elasticache_cluster.elasticache.cache_nodes.0.address
}

output "memcached_endpoint" {
  value = aws_elasticache_cluster.elasticache.configuration_endpoint
}

output "security_group_id" {
  value = aws_security_group.elasticache.id
}