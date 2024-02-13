
resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier        = var.cluster_identifier
  db_subnet_group_name      = aws_db_subnet_group.rds_subnet_group.name
  engine                    = var.engine
  engine_version            = var.engine_version
  engine_mode               = var.engine_mode
  database_name             = var.db_name
  master_username           = var.master_username
  master_password           = var.master_password
  final_snapshot_identifier = var.final_snapshot_identifier
  skip_final_snapshot       = var.skip_final_snapshot

  backup_retention_period = var.backup_retention_period
  deletion_protection     = var.deletion_protection

  scaling_configuration {
    auto_pause               = var.auto_pause
    max_capacity             = var.max_capacity
    min_capacity             = var.min_capacity
    seconds_until_auto_pause = var.seconds_until_auto_pause
    timeout_action           = var.timeout_action
  }

  enable_http_endpoint = var.enable_http_endpoint
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "testy-subnet-group"
  subnet_ids = var.subnet_ids
}
