output "idt-pagerduty-webhook-url" {
  value       = module.idt-pagerduty-webhook.function_url
  description = "The URL of the deployed Lambda"
}

