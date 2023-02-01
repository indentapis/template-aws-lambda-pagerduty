terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + PagerDuty Integration

# Details: https://github.com/indentapis/integrations/tree/df7a83d97d7220dc20566871e81d90a20ec160e0/packages/stable/indent-integration-pagerduty
# Last Change: https://github.com/indentapis/integrations/commit/df7a83d97d7220dc20566871e81d90a20ec160e0

module "idt-pagerduty-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-pagerduty-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/pagerduty-df7a83d97d7220dc20566871e81d90a20ec160e0-function.zip"
    deps_key     = "webhooks/aws/lambda/pagerduty-df7a83d97d7220dc20566871e81d90a20ec160e0-deps.zip"
  }
  env = {
    PAGERDUTY_KEY                     = var.pagerduty_key
    AUTO_APPROVAL_PAGERDUTY_SCHEDULES = var.auto_approval_pagerduty_schedules
  }
}

