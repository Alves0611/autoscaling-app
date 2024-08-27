resource "aws_launch_template" "this" {
  name_prefix   = local.namespaced_service_name
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_config.type
  key_name      = var.instance_config.key_name

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.autoscaling_group.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      "Name" = "${local.namespaced_service_name}-server"
    }
  }
}
