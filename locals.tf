locals {
  namespaced_service_name = "${var.service_name}-${var.environment}"

  subnets = {
    "pub_a" = {
      cidr_block = "10.0.0.0/20"
      az         = "a"
      name       = "public-a"
    }
    "pub_b" = {
      cidr_block = "10.0.16.0/20"
      az         = "b"
      name       = "public-b"
    }
    "pub_c" = {
      cidr_block = "10.0.32.0/20"
      az         = "c"
      name       = "public-c"
    }
    "pvt_a" = {
      cidr_block = "10.0.128.0/20"
      az         = "a"
      name       = "private-a"
    }
    "pvt_b" = {
      cidr_block = "10.0.144.0/20"
      az         = "b"
      name       = "private-b"
    }
    "pvt_c" = {
      cidr_block = "10.0.160.0/20"
      az         = "c"
      name       = "private-c"
    }
  }
  subnet_ids = {
    for k, v in aws_subnet.this : v.tags.Name => v.id
  }
  public_subnet_ids   = [aws_subnet.this["pub_a"].id, aws_subnet.this["pub_b"].id, aws_subnet.this["pub_c"].id]
  private_subnet_ids   = [aws_subnet.this["pvt_a"].id, aws_subnet.this["pvt_b"].id, aws_subnet.this["pvt_c"].id]
  internet_cidr_block = "0.0.0.0/0"
  common_tags = {
    Component = "auto-scalable"
    ManagedBy = "Terraform"
    Env       = var.environment
  }
}
