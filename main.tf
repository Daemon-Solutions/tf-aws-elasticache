resource "aws_security_group" "elasticache" {
  name        = "${var.name}"
  description = "Elasticache security group for ${var.name}"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "elasticache-in" {
    type              = "ingress"
    protocol          = "tcp"
    from_port         = "${var.port}"
    to_port           = "${var.port}"
    security_group_id = "${aws_security_group.elasticache.id}"
    cidr_blocks       = ["${var.vpc_cidr}"]
  }

resource "aws_elasticache_subnet_group" "main" {
  name        = "${var.name}"
  description = "Elasticache subnets for ${var.name}"
  subnet_ids  = ["${var.subnets}"]
}

resource "aws_elasticache_cluster" "elasticache" {
  cluster_id                = "${var.name}"
  engine                    = "${var.engine}"
  engine_version            = "${var.engine_version}"
  node_type                 = "${var.instance_type}"
  port                      = "${var.port}"
  num_cache_nodes           = "${var.cache_nodes}"
  parameter_group_name      = "${var.parameter_group}"
  subnet_group_name         = "${aws_elasticache_subnet_group.main.name}"
  security_group_ids        = ["${aws_security_group.elasticache.id}"]
  #snapshot_window           = "${var.snapshot_window}"
  #snapshot_retention_limit  = "${var.snapshot_retention_limit}"
  tags {
    Name = "${var.name}"
  }
}
