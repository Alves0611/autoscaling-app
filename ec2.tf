resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_config.type

  vpc_security_group_ids = [aws_security_group.jenkins.id]
  subnet_id              = aws_subnet.this["pub_a"].id
  availability_zone      = aws_subnet.this["pub_a"].availability_zone

  tags = {
    "Name" = "${local.namespaced_service_name}-jenkins"
  }
}
