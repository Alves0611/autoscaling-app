resource "aws_launch_template" "this" {
  name_prefix   = local.namespaced_service_name
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_config.type
  key_name      = var.instance_config.key_name

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.autoscaling_group.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      "Name" = "${local.namespaced_service_name}-server"
    }
  }
}

resource "aws_autoscaling_group" "this" {
  name = local.namespaced_service_name

  desired_capacity          = var.autoscaling_group_config.desired_capacity
  min_size                  = var.autoscaling_group_config.min_size
  max_size                  = var.autoscaling_group_config.max_size
  health_check_grace_period = var.autoscaling_group_config.health_check_grace_period
  health_check_type         = var.autoscaling_group_config.health_check_type
  force_delete              = var.autoscaling_group_config.force_delete

  target_group_arns   = [aws_alb_target_group.http.id]
  vpc_zone_identifier = local.private_subnet_ids

  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }
}

resource "aws_autoscaling_policy" "cpu" {
  enabled                = var.autoscaling_policy_cpu.enabled
  name                   = var.autoscaling_policy_cpu.name
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.this.name

  target_tracking_configuration {
    disable_scale_in = var.autoscaling_policy_cpu.disable_scale_in
    target_value     = var.autoscaling_policy_cpu.target_value

    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}

resource "aws_autoscaling_policy" "load_balancer" {
  enabled                = var.autoscaling_policy_alb.enabled
  name                   = var.autoscaling_policy_alb.name
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.this.name

  target_tracking_configuration {
    disable_scale_in = var.autoscaling_policy_alb.disable_scale_in
    target_value     = var.autoscaling_policy_alb.target_value

    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${aws_alb.this.arn_suffix}/${aws_alb_target_group.http.arn_suffix}"
    }
  }
}
