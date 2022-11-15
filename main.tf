terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + PagerDuty Integration

# Details: https://github.com/indentapis/integrations/tree/72262bbe55f2582bb1f9aa784ceb620d6457ed7b/packages/stable/indent-integration-pagerduty
# Last Change: https://github.com/indentapis/integrations/commit/72262bbe55f2582bb1f9aa784ceb620d6457ed7b

module "idt-pagerduty-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-pagerduty-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/pagerduty-72262bbe55f2582bb1f9aa784ceb620d6457ed7b-function.zip"
    deps_key     = "webhooks/aws/lambda/pagerduty-72262bbe55f2582bb1f9aa784ceb620d6457ed7b-deps.zip"
  }
  env = {
    PAGERDUTY_KEY                     = var.pagerduty_key
    AUTO_APPROVAL_PAGERDUTY_SCHEDULES = var.auto_approval_pagerduty_schedules
  }
}

