
variable "cluster_identifier" {
  description = "The identifier for the Aurora cluster"
  type        = string
}

variable "engine" {
  description = "The database engine type"
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
}

variable "engine_mode" {
  description = "The engine mode for the database"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "master_username" {
  description = "The master username for the database"
  type        = string
}

variable "master_password" {
  description = "The master password for the database"
  type        = string
}

variable "final_snapshot_identifier" {
  description = "The final snapshot identifier for the database"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Boolean to skip final snapshot"
  type        = bool
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
}

variable "auto_pause" {
  description = "Enable auto pause"
  type        = bool
}

variable "max_capacity" {
  description = "Maximum capacity of the cluster"
  type        = number
}

variable "min_capacity" {
  description = "Minimum capacity of the cluster"
  type        = number
}

variable "seconds_until_auto_pause" {
  description = "Seconds until auto pause"
  type        = number
}

variable "timeout_action" {
  description = "Timeout action"
  type        = string
}

variable "enable_http_endpoint" {
  description = "Enable HTTP endpoint"
  type        = bool
}

variable "subnet_ids" {
  description = "List of subnet IDs where the Aurora cluster will be deployed"
  type        = list(string)
}
