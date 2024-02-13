
# Create Security Group
resource "aws_security_group" "alb_sg" {
  name        = "${var.security_group_name}-sg"
  description = "Security group for the Application Load Balancer"

  # Define ingress rules for HTTP
  dynamic "ingress" {
    for_each = var.http_ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  /*
  # Define ingress rules for HTTPS
  dynamic "ingress" {
    for_each = var.https_ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
*/

  # Define outbound traffic rules
  dynamic "egress" {
    for_each = var.outbound_traffic
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

# Create Application Load Balancer
resource "aws_lb" "alb" {
  name               = var.loadbalancer_name
  internal           = var.alb_internal
  load_balancer_type = var.alb_type
  ip_address_type    = var.ip_address_type
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.alb_subnets
  tags = {
    Name = var.loadbalancer_name
  }
}

# Create Target Group
resource "aws_lb_target_group" "target_group" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id # Replace with your VPC ID

  health_check {
    enabled             = var.target_group_health_check_enabled
    protocol            = var.target_group_health_check_protocol
    port                = var.target_group_health_check_port
    path                = var.target_group_health_check_path
    interval            = var.target_group_health_check_interval
    timeout             = var.target_group_health_check_timeout
    healthy_threshold   = var.target_group_health_check_healthy_threshold
    unhealthy_threshold = var.target_group_health_check_unhealthy_threshold
    matcher             = var.target_group_health_check_success_codes
  }

  # Tags for the target group
  tags = var.target_group_tags
}

/*
# Register targets (instances or Lambda functions) with the Target Group
resource "aws_lb_target_group_attachment" "instance_attachment" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.instance_ip
  port             = var.instance_port
}

resource "aws_lb_target_group_attachment" "lambda_attachment" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.lambda_function_arn
  port             = var.lambda_port
}
*/

# Create Listeners and Routing
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = var.default_action_type
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

/*
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.https_listener_port
  protocol          = var.https_listener_protocol

  default_action {
    type             = var.https_default_action_type
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
*/

# Create Launch Template
resource "aws_launch_template" "example" {
  name = var.launch_template_name

  block_device_mappings {
    device_name = var.device_name

    ebs {
      volume_size = var.volume_size
    }
  }

  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  network_interfaces {
    security_groups = [aws_security_group.alb_sg.id]
  }
}

# Create Auto Scaling Group
resource "aws_autoscaling_group" "example" {
  name                      = var.asg_name
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period

  launch_template {
    id      = aws_launch_template.example.id
    version = var.launch_template_version
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = var.propagate_at_launch
    }
  }

  vpc_zone_identifier = var.subnets

  # Attach to the existing Application Load Balancer
  target_group_arns = [aws_lb_target_group.target_group.arn]

  # Enable or disable CloudWatch monitoring
  # Enable or disable CloudWatch monitoring
  enabled_metrics = var.cloudwatch_enabled_metrics == true ? ["GroupDesiredCapacity",
    "GroupInServiceInstances", "GroupPendingInstances",
    "GroupMinSize", "GroupMaxSize", "GroupInServiceCapacity",
    "GroupPendingCapacity", "GroupStandbyCapacity",
  "GroupTerminatingCapacity", "GroupTotalInstances"] : []
}
