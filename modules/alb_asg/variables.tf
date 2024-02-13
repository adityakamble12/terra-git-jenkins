
variable "security_group_name" {
  description = "Name of the security group for the Application Load Balancer"
  type        = string
}

variable "http_ingress" {
  description = "Ingress rules for HTTP"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

/*
variable "https_ingress" {
  description = "Ingress rules for HTTPS"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
*/

variable "outbound_traffic" {
  description = "Outbound traffic rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}



variable "loadbalancer_name" {
  description = "Name of the Application Load Balancer"
}

variable "alb_internal" {
  description = "Boolean flag for internal ALB"
  type        = bool
}

variable "alb_type" {
  description = "Type of the load balancer"
}

variable "ip_address_type" {
  description = "Type of IP addresses for the ALB (ipv4 or dualstack)"
}

variable "alb_subnets" {
  description = "List of subnet IDs where the ALB will be deployed"
  type        = list(string)
}

variable "target_group_name" {
  description = "Name of the Target Group"
}

variable "target_group_port" {
  description = "Port for the Target Group"
}

variable "target_group_protocol" {
  description = "Protocol for the Target Group"
}

variable "vpc_id" {
  description = "ID of the VPC"
}

variable "target_group_health_check_enabled" {
  description = "Enable or disable health checks for the target group"
  type        = bool
}

variable "target_group_health_check_protocol" {
  description = "Protocol to use for health checks (HTTP, HTTPS, TCP, SSL)"
  type        = string
}

variable "target_group_health_check_port" {
  description = "Port to use for health checks"
  type        = number
}

variable "target_group_health_check_path" {
  description = "Path to use for HTTP/HTTPS health checks"
  type        = string
}

variable "target_group_health_check_interval" {
  description = "Interval between health checks (in seconds)"
  type        = number
}

variable "target_group_health_check_timeout" {
  description = "Timeout for health checks (in seconds)"
  type        = number
}

variable "target_group_health_check_healthy_threshold" {
  description = "Number of consecutive successful health checks required to mark a target healthy"
  type        = number
}

variable "target_group_health_check_unhealthy_threshold" {
  description = "Number of consecutive failed health checks required to mark a target unhealthy"
  type        = number
}

variable "target_group_health_check_success_codes" {
  description = "HTTP codes considered as successful for health checks"
  type        = string
}

variable "target_group_tags" {
  description = "Tags for the target group"
  type        = map(string)
}

/*
variable "instance_ip" {
  description = "IP address of the instance to register with the target group"
}


variable "instance_port" {
  description = "Port for the instance"
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function to register with the target group"
}

variable "lambda_port" {
  description = "Port for the Lambda function"
}
*/


variable "listener_port" {
  description = "Port for the listener"
}

variable "listener_protocol" {
  description = "Protocol for the listener"
}

variable "default_action_type" {
  description = "Type for the default action"
}

/*
variable "https_listener_port" {
  description = "Port for the HTTPS listener"
}

variable "https_listener_protocol" {
  description = "Protocol for the HTTPS listener"
}

variable "https_default_action_type" {
  description = "Type for the default action of HTTPS listener"
}
*/


variable "launch_template_name" {
  description = "Name for the launch template"
}

variable "device_name" {
  description = "Device name for block device mapping"
}

variable "volume_size" {
  description = "Volume size for the EBS"
}

variable "ami_id" {
  description = "ID of the AMI to use for instances"
}

variable "instance_type" {
  description = "Type of EC2 instances"
}

variable "key_name" {
  description = "Name of the key pair"
}

variable "subnets" {
  description = "List of subnets to use for the Auto Scaling Group"
  type        = list(string)
}


variable "asg_name" {
  description = "Name of the Auto Scaling Group"
}

variable "desired_capacity" {
  description = "Desired capacity for the Auto Scaling Group"
}

variable "max_size" {
  description = "Maximum size for the Auto Scaling Group"
}

variable "min_size" {
  description = "Minimum size for the Auto Scaling Group"
}

variable "health_check_type" {
  description = "Type of health check for the Auto Scaling Group"
}

variable "health_check_grace_period" {
  description = "Health check grace period for the Auto Scaling Group"
}

variable "launch_template_version" {
  description = "Version of the launch template"
}

variable "tags" {
  description = "Tags for the Auto Scaling Group"
  type        = map(string)
}

variable "propagate_at_launch" {
  description = "Whether tags should be propagated to instances launched in the Auto Scaling Group"
  type        = bool
}

variable "cloudwatch_enabled_metrics" {
  description = "Enable or disable CloudWatch monitoring for Auto Scaling Group"
  type        = bool
}