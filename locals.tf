locals {
  common_tags = {
    Component = "auto-scalable"
    ManagedBy = "Terraform"
    Env       = var.environment
  }
}
