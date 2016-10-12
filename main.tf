resource "aws_security_group" "elasticache" {
  name        = "${var.name}"
  description = "Elasticache security group ${var.name}"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = "${var.port}"
    to_port         = "${var.port}"
    security_groups = ["${var.source_sgs}"]
    protocol        = "tcp"
  }
}

resource "aws_elasticache_subnet_group" "main" {
  name        = "${var.name}"
  description = "Elasticache subnets for ${var.name}"
  subnet_ids  = ["${var.subnets}"]
}

resource "aws_elasticache_cluster" "elasticache" {
  count = "${var.enable_elasticache_cluster}"

  cluster_id           = "${var.name}"
  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  node_type            = "${var.instance_type}"
  port                 = "${var.port}"
  num_cache_nodes      = "${var.cache_nodes}"
  parameter_group_name = "${var.parameter_group}"
  subnet_group_name    = "${aws_elasticache_subnet_group.main.name}"
  security_group_ids   = ["${aws_security_group.elasticache.id}"]

  tags {
    Name    = "${var.name}"
    owner   = "${var.owner}"
    envname = "${var.envname}"
  }
}

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

resource "aws_route53_record" "elasticache" {
  count   = "${var.enable_elasticache_cluster}"
  zone_id = "${var.r53_zone_id}"
  name    = "${var.name}.${var.domain}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_elasticache_cluster.elasticache.cache_nodes}"]
}

resource "aws_route53_record" "elasticache_rep_group" {
  count   = "${var.enable_replication_group}"
  zone_id = "${var.r53_zone_id}"
  name    = "${var.name}.${var.domain}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${aws_elasticache_replication_group.elasticache_rep_group.primary_endpoint_address}"]
}
