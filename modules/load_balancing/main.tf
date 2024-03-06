
// Target Groups
resource "aws_lb_target_group" "heating" {
  name     = "Heating-Target-Group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/api/heating/health"
    protocol            = "HTTP"
  }
}

resource "aws_lb_target_group" "lighting" {
  name     = "Lighting-Target-Group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/api/lights/health"
    protocol            = "HTTP"
  }
}

resource "aws_lb_target_group" "auth" {
  name     = "Auth-Target-Group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/api/auth"
    protocol            = "HTTP"
  }
}

resource "aws_lb_target_group" "status" {
  name     = "Status-Target-Group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/api/status/health"
    protocol            = "HTTP"
  }
}

// Target Group Attachments
resource "aws_lb_target_group_attachment" "heating_attachement" {

  target_group_arn = aws_lb_target_group.heating.arn
  target_id        = var.heating_instance_id
  port             = 3000
}

resource "aws_lb_target_group_attachment" "lighting_attachement" {

  target_group_arn = aws_lb_target_group.lighting.arn
  target_id        = var.lighting_instance_id
  port             = 3000
}

resource "aws_lb_target_group_attachment" "auth_attachement" {

  target_group_arn = aws_lb_target_group.auth.arn
  target_id        = var.auth_instance_id
  port             = 3000
}

resource "aws_lb_target_group_attachment" "status_attachement" {

  target_group_arn = aws_lb_target_group.status.arn
  target_id        = var.status_instance_id
  port             = 3000
}

// Load Balancers
resource "aws_lb" "public-lb" {
  name               = "Public-Load-Balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.public_subnets

  enable_deletion_protection = false
}

resource "aws_lb" "private-lb" {
  name               = "Private-Load-Balancer"
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.private_subnets

  enable_deletion_protection = false
}

// Listeners

resource "aws_lb_listener" "public-lb-listener" {
  load_balancer_arn = aws_lb.public-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: Not Found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener" "private-lb-listener" {
  load_balancer_arn = aws_lb.private-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: Not Found"
      status_code  = "404"
    }
  }
}

// Listener rules
resource "aws_lb_listener_rule" "heating_rule" {
  listener_arn = aws_lb_listener.public-lb-listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.heating.arn
  }

  condition {
    path_pattern {
      values = ["/api/heating*"]
    }
  }
}

resource "aws_lb_listener_rule" "auth_rule" {
  listener_arn = aws_lb_listener.private-lb-listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.auth.arn
  }

  condition {
    path_pattern {
      values = ["/api/auth*"]
    }
  }
}

resource "aws_lb_listener_rule" "status_rule" {
  listener_arn = aws_lb_listener.public-lb-listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.status.arn
  }

  condition {
    path_pattern {
      values = ["/api/status*"]
    }
  }
}

resource "aws_lb_listener_rule" "lighting_rule" {
  listener_arn = aws_lb_listener.public-lb-listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lighting.arn
  }

  condition {
    path_pattern {
      values = ["/api/lights*"]
    }
  }
}