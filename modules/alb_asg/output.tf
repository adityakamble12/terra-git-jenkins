
output "loadbalancer_name" {
  value = aws_lb.alb.name
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "target_group_name" {
  value = aws_lb_target_group.target_group.name
}

output "launch_template_name" {
  value = aws_launch_template.example.name
}

output "alb_security_group_name" {
  value = aws_security_group.alb_sg.name
}

output "auto_scaling_group_name" {
  value = aws_autoscaling_group.example.name
}
