terraform {
  backend "s3" {
    encrypt = true
    bucket  = ""
    region  = "us-west-2"
    key     = "indent/terraform.tfstate"
  }

}

# Indent + PagerDuty Integration

# Details: https://github.com/indentapis/integrations/tree/ec5a76293c4b5cc721df6b3290c0c3afeab4ce8e/packages/stable/indent-integration-pagerduty
# Last Change: https://github.com/indentapis/integrations/commit/ec5a76293c4b5cc721df6b3290c0c3afeab4ce8e

module "idt-pagerduty-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-pagerduty-webhook"
  indent_webhook_secret = var.indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/pagerduty-ec5a76293c4b5cc721df6b3290c0c3afeab4ce8e-function.zip"
    deps_key     = "webhooks/aws/lambda/pagerduty-ec5a76293c4b5cc721df6b3290c0c3afeab4ce8e-deps.zip"
  }
  env = {
    PAGERDUTY_KEY = var.pagerduty_key
  }
}

