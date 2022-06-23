terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + PagerDuty Integration

# Details: https://github.com/indentapis/integrations/tree/d8f5d4b6705d3311a5b4e7c8047fb31812ef6481/packages/stable/indent-integration-pagerduty
# Last Change: https://github.com/indentapis/integrations/commit/d8f5d4b6705d3311a5b4e7c8047fb31812ef6481

module "idt-pagerduty-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-pagerduty-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/pagerduty-d8f5d4b6705d3311a5b4e7c8047fb31812ef6481-function.zip"
    deps_key     = "webhooks/aws/lambda/pagerduty-d8f5d4b6705d3311a5b4e7c8047fb31812ef6481-deps.zip"
  }
  env = {
    PAGERDUTY_KEY = var.pagerduty_key
  }
}

