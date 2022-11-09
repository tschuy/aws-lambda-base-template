# Indent + Okta Integration

# Details: https://github.com/indentapis/integrations/tree/f0cea0e363f8950c7a217d186df6c377ed52e9d7/packages/stable/indent-integration-okta
# Last Change: https://github.com/indentapis/integrations/commit/f0cea0e363f8950c7a217d186df6c377ed52e9d7

module "idt-okta-webhook" {
  source                = "git::https://github.com/indentapis/integrations//terraform/modules/indent_runtime_aws_lambda"
  name                  = "idt-okta-webhook"
  indent_webhook_secret = var.okta_indent_webhook_secret
  artifact = {
    bucket       = "indent-artifacts-us-west-2"
    function_key = "webhooks/aws/lambda/okta-f0cea0e363f8950c7a217d186df6c377ed52e9d7-function.zip"
    deps_key     = "webhooks/aws/lambda/okta-f0cea0e363f8950c7a217d186df6c377ed52e9d7-deps.zip"
  }

  env = {
    OKTA_DOMAIN       = "${var.okta_prefix}.okta.com"
    OKTA_SLACK_APP_ID = var.okta_slack_app_id
    OKTA_CLIENT_ID    = data.terraform_remote_state.stage1.outputs.idt-okta-okta-app-oauth-client-id
    OKTA_PRIVATE_KEY  = file("./private.pem")
  }
}

output "idt-okta-webhook-url" {
  value       = module.idt-okta-webhook.function_url
  description = "The URL of the deployed Lambda"
}
