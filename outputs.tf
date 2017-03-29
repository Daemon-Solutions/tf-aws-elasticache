output "elasticache_cluster_redis_endpoint" {
  value = "${aws_elasticache_cluster.elasticache.cache_nodes}"
}

output "elasticache_cluster_node_address" {
  value = "${aws_elasticache_cluster.elasticache.cache_nodes.0.address}"
}

output "elasticache_cluster_memcached_endpoint" {
  value = "${aws_elasticache_cluster.elasticache.configuration_endpoint}"
}
