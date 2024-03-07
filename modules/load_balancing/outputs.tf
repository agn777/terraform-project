output "lb_dns_name" {
  value = aws_lb.public-lb.dns_name
}

output "heating_target_group_arn" {
  value = aws_lb_target_group.heating.arn
}

output "lighting_target_group_arn" {
  value = aws_lb_target_group.lighting.arn
}

output "auth_target_group_arn" {
  value = aws_lb_target_group.auth.arn
}

output "status_target_group_arn" {
  value = aws_lb_target_group.status.arn
}

output "target_group_arns" {
  value = {
    heating = aws_lb_target_group.heating.arn
    lighting = aws_lb_target_group.lighting.arn
    auth = aws_lb_target_group.auth.arn
    status = aws_lb_target_group.status.arn
  }
}