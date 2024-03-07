resource "aws_autoscaling_group" "group" {
  count = length(var.services)

  name                      = "${keys(var.services)[count.index]}_autoscaling_group"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = var.req_size
  force_delete              = true
  vpc_zone_identifier       = var.public_subnets
  launch_template {
    id = aws_launch_template.template[count.index].id
  }
}

resource "aws_launch_template" "template" {
  count = length(var.services)

  name = "${keys(var.services)[count.index]}_launch_template"

  image_id = values(var.services)[count.index].ami

  instance_type = var.instance_type

  key_name = var.key_name

  network_interfaces {
    associate_public_ip_address = values(var.services)[count.index].associate_public_ip_address
    security_groups             = var.vpc_security_group_ids
    subnet_id                   = values(var.services)[count.index].subnet_id
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.services[keys(var.services)[count.index]].name} ${count.index + 1}"
    }
  }
}

resource "aws_autoscaling_attachment" "attachment" {
  count = length(var.services)

  autoscaling_group_name = aws_autoscaling_group.group[count.index].id
  lb_target_group_arn    = var.lb_target_group_arns[keys(var.services)[count.index]]
}
