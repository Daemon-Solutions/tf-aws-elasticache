output "cluster_endpoint" {
  value = "${aws_elasticache_cluster.elasticache.cache_nodes}"
}

output "node_address" {
  value = "${aws_elasticache_cluster.elasticache.cache_nodes.0.address}"
}

output "memcached_endpoint" {
  value = "${aws_elasticache_cluster.elasticache.configuration_endpoint}"
}

output "replication_group_endpoint" {
  value = "${aws_elasticache_replication_group.elasticache_rep_group.primary_endpoint_address}"
}
