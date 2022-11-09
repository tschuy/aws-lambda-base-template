# Configure the Okta Provider
provider "okta" {
  org_name  = var.okta_prefix
  base_url  = "okta.com"
  api_token = var.okta_token
}

resource "okta_app_oauth" "indent" {
  label                      = "indent_integration"
  type                       = "service"
  token_endpoint_auth_method = "private_key_jwt"
  grant_types                = ["client_credentials"]
  response_types             = ["token"]
  pkce_required              = true

  jwks {
    kty = "RSA"
    kid = "SIGNING_KEY"
    e   = "AQAB"
    n   = var.okta_jwk_n
  }
}

resource "okta_app_oauth_api_scope" "indent-scopes" {
  app_id = okta_app_oauth.indent.id
  issuer = "https://${var.okta_prefix}.okta.com"
  scopes = ["okta.groups.manage", "okta.users.manage"]
}

output "idt-okta-okta-app-oauth-client-id" {
  value       = okta_app_oauth.indent.id
  description = "oauth client id of application"
}
