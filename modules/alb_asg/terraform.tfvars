
# Create Security Groups
security_group_name = "my-terra-alb" # Replace with your desired security group name

# Define ingress rules for HTTP
http_ingress = [
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

/*
# Define ingress rules for HTTPS
https_ingress = [
  {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
*/

# Define outbound traffic rules
outbound_traffic = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

# Create Application Load Balancer
loadbalancer_name = "terra-load-balancer"
alb_internal      = false
alb_type          = "application"
ip_address_type   = "ipv4"
alb_subnets       = ["subnet-02423996eaa22ea36", "subnet-03020bda9b95fc110", "subnet-032c25698ddfd1656"] # Replace with your subnet IDs


# Create Target Group
target_group_name     = "terra-target-group"
target_group_port     = 80
target_group_protocol = "HTTP"
vpc_id                = "vpc-053af984d07b17dfc"

target_group_health_check_enabled             = true
target_group_health_check_protocol            = "HTTP"
target_group_health_check_port                = 80
target_group_health_check_path                = "/"
target_group_health_check_interval            = 30
target_group_health_check_timeout             = 5
target_group_health_check_healthy_threshold   = 2
target_group_health_check_unhealthy_threshold = 2
target_group_health_check_success_codes       = 200

# Tags for the target group
target_group_tags = {
  Name = "terra-target-group"
}

/*
# Register targets (instances or Lambda functions) with the Target Group
instance_ip         = "52.14.193.46"
instance_port       = 80
lambda_function_arn = "arn:aws:lambda:us-west-2:123456789012:function:my-lambda-function"
lambda_port         = 80
*/

# Create Listeners and Routing
listener_port       = 80
listener_protocol   = "HTTP"
default_action_type = "forward"

/*
https_listener_port       = 443
https_listener_protocol   = "HTTPS"
https_default_action_type = "forward"
*/

# Create Launch Template
launch_template_name = "terra-launch-template"
device_name          = "/dev/sda1"
volume_size          = 30
ami_id               = "ami-0b57d5684a491510e"
instance_type        = "t2.micro"
key_name             = "terra-key"
subnets              = ["subnet-02423996eaa22ea36", "subnet-03020bda9b95fc110", "subnet-032c25698ddfd1656"]

# Create Auto Scaling Group
asg_name                  = "terra-asg"
desired_capacity          = 2
max_size                  = 5
min_size                  = 1
health_check_type         = "ELB"
health_check_grace_period = 300
launch_template_version   = "$Latest"

# Define your tags
tags = {
  Name = "terra-asg"
}

# Propagate at launch
propagate_at_launch = true

cloudwatch_enabled_metrics = false