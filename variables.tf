variable "aws_region" {
  description = "AWS region where the Network resources will be deployed, e.g., 'eu-central-1' for the Europe (Frankfurt) region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment name, such as 'dev', 'test', 'prod'. This categorizes the Network resources by their usage stage"
  type        = string
  default     = "dev"
}

variable "service_name" {
  type        = string
  description = "The service name identifier"
  default     = "autoscaling-app"
}

variable "instance_config" {
  description = "Instance configuration"
  type = object({
    ami      = string
    type     = string
    key_name = optional(string, null)
  })
  default = {
    ami      = "ami-0479653c00e0a5e59"
    type     = "t4g.micro"
    key_name = "cleber_kp"
  }
}