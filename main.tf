resource "aws_security_group" "elasticache" {
  count = "${var.name == "laguna-live" ? 1 : 0}"
  name = "${var.name}"
  description = "Elasticache security group ${var.name}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = "${var.port}"
    to_port   = "${var.port}"
    security_groups = ["${split(",", var.source_sgs)}"]
    protocol = "tcp"
  }

}

resource "aws_elasticache_subnet_group" "main" {
  count       = "${var.name == "laguna-live" ? 1 : 0}"
  name        = "${var.name}"
  description = "Elasticache subnets for ${var.name}"
  subnet_ids  = ["${split(",", var.subnets)}"]
}

resource "aws_elasticache_cluster" "elasticache" {
  count                = "${var.name == "laguna-live" ? 1 : 0}"
  cluster_id           = "${var.name}"
  engine               = "${var.engine}"
  engine_version       = "${var.engine_version}"
  node_type            = "${var.instance_type}"
  port                 = "${var.port}"
  num_cache_nodes      = "${var.cache_nodes}"
  parameter_group_name = "${var.parameter_group}"
  subnet_group_name    = "${aws_elasticache_subnet_group.main.name}"
  security_group_ids   = ["${aws_security_group.elasticache.id}"]
  tags                 { Name = "${var.name}" }
}
