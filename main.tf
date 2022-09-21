terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + PagerDuty Integration

# Details: https://github.com/indentapis/integrations/tree/fc629d5c057133dd97e04244485774a57fd10b71/packages/stable/indent-integration-pagerduty
# Last Change: https://github.com/indentapis/integrations/commit/fc629d5c057133dd97e04244485774a57fd10b71

module "idt-pagerduty-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-pagerduty-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/pagerduty-fc629d5c057133dd97e04244485774a57fd10b71-function.zip"
    deps_key     = "webhooks/aws/lambda/pagerduty-fc629d5c057133dd97e04244485774a57fd10b71-deps.zip"
  }
  env = {
    PAGERDUTY_KEY                     = var.pagerduty_key
    AUTO_APPROVAL_PAGERDUTY_SCHEDULES = var.auto_approval_pagerduty_schedules
  }
}

