resource "aws_alb" "this" {
  name               = local.namespaced_service_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = local.public_subnet_ids

  tags = {
    "Name" = local.namespaced_service_name
  }
}
