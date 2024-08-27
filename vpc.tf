resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = local.namespaced_service_name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = local.namespaced_service_name
  }
}

resource "aws_subnet" "this" {
  for_each = local.subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr_block
  availability_zone = "${var.aws_region}${each.value.az}"

  tags = {
    "Name" = "${local.namespaced_service_name}-${each.value.name}"
  }
}
