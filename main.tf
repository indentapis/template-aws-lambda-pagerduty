terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + PagerDuty Integration

# Details: https://github.com/indentapis/integrations/tree/1cfcaeb34a36acfe963544635eb971c89ac38d16/packages/stable/indent-integration-pagerduty
# Last Change: https://github.com/indentapis/integrations/commit/1cfcaeb34a36acfe963544635eb971c89ac38d16

module "idt-pagerduty-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-pagerduty-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/pagerduty-1cfcaeb34a36acfe963544635eb971c89ac38d16-function.zip"
    deps_key     = "webhooks/aws/lambda/pagerduty-1cfcaeb34a36acfe963544635eb971c89ac38d16-deps.zip"
  }
  env = {
    PAGERDUTY_KEY = var.pagerduty_key
  }
}

