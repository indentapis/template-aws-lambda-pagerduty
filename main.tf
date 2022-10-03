terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + PagerDuty Integration

# Details: https://github.com/indentapis/integrations/tree/f0cea0e363f8950c7a217d186df6c377ed52e9d7/packages/stable/indent-integration-pagerduty
# Last Change: https://github.com/indentapis/integrations/commit/f0cea0e363f8950c7a217d186df6c377ed52e9d7

module "idt-pagerduty-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-pagerduty-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/pagerduty-f0cea0e363f8950c7a217d186df6c377ed52e9d7-function.zip"
    deps_key     = "webhooks/aws/lambda/pagerduty-f0cea0e363f8950c7a217d186df6c377ed52e9d7-deps.zip"
  }
  env = {
    PAGERDUTY_KEY                     = var.pagerduty_key
    AUTO_APPROVAL_PAGERDUTY_SCHEDULES = var.auto_approval_pagerduty_schedules
  }
}

