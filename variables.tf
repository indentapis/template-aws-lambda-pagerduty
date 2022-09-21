variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "aws_profile" {
  type    = string
  default = "default"
}

variable "indent_webhook_secret" {
  type      = string
  sensitive = true
}

variable "pagerduty_key" {
  type      = string
  default   = ""
  sensitive = true
}

variable "auto_approval_pagerduty_schedules" {
  type      = string
  default   = ""
  sensitive = true
}

