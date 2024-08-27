locals {
  namespaced_service_name = "${var.service_name}-${var.environment}"

  common_tags = {
    Component = "auto-scalable"
    ManagedBy = "Terraform"
    Env       = var.environment
  }
}
