terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + PagerDuty Integration

# Details: https://github.com/indentapis/integrations/tree/17108bd50ac2085c099c40b348776fc655915b48/packages/stable/indent-integration-pagerduty
# Last Change: https://github.com/indentapis/integrations/commit/17108bd50ac2085c099c40b348776fc655915b48

module "idt-pagerduty-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-pagerduty-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/pagerduty-17108bd50ac2085c099c40b348776fc655915b48-function.zip"
    deps_key     = "webhooks/aws/lambda/pagerduty-17108bd50ac2085c099c40b348776fc655915b48-deps.zip"
  }
  env = {
    PAGERDUTY_KEY                     = var.pagerduty_key
    AUTO_APPROVAL_PAGERDUTY_SCHEDULES = var.auto_approval_pagerduty_schedules
  }
}

