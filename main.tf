resource "aws_elasticache_subnet_group" "main" {
  name        = "${var.name}"
  description = "Elasticache subnets for ${var.name}"
  subnet_ids  = ["${split(",", var.subnets)}"]
}

resource "aws_elasticache_cluster" "elasticache" {
  cluster_id           = "${var.name}"
  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  node_type            = "${var.instance_type}"
  port                 = "${var.port}"
  num_cache_nodes      = "${var.cache_nodes}"
  parameter_group_name = "${var.parameter_group}"
  subnet_group_name    = "${aws_elasticache_subnet_group.main.name}"
  security_group_ids   = ["${split(",", var.security_groups)}"]
  tags                 { Name = "${var.name}" }
}
