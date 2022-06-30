terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + PagerDuty Integration

# Details: https://github.com/indentapis/integrations/tree/8e1a816efa0f0f4b1fd4fc5bda559ec8f6061c5c/packages/stable/indent-integration-pagerduty
# Last Change: https://github.com/indentapis/integrations/commit/8e1a816efa0f0f4b1fd4fc5bda559ec8f6061c5c

module "idt-pagerduty-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-pagerduty-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/pagerduty-8e1a816efa0f0f4b1fd4fc5bda559ec8f6061c5c-function.zip"
    deps_key     = "webhooks/aws/lambda/pagerduty-8e1a816efa0f0f4b1fd4fc5bda559ec8f6061c5c-deps.zip"
  }
  env = {
    PAGERDUTY_KEY = var.pagerduty_key
  }
}

