# Indent + AWS Lambda integrations

This repository contains the base deployment of AWS Lambda integrations for [Indent](https://indent.com).

## Quicklinks

- [Indent Documentation Index](https://indent.com/docs)
- [Indent Support](https://support.indent.com)

## How it works

The default repository contains an empty stage0 and stage1, with just the Terraform backend configuration. For managed repositories, Indent will add `idt-*.tf` files containing managed
deployments -- so for a managed Okta integration, there will be a `stage0/idt-okta.tf` and `stage1/idt-okta.tf` file containing the deployment configuration. 

## stage0

`stage0` contains certain resources that require more sensitive tokens and permissions to deploy but generally require less frequent deployment. For instance, Okta tokens are tied to users and have limited scope configurability. Since the Okta token is only needed for to create an Okta service app at the beginning of the integration lifecycle, after the app is created, if the token is revoked, we can skip `stage0` without blocking updates to the integrations themselves.

## stage1

`stage1` contains the integration lambda deployments themselves. Updating integrations is a more frequent operation. For the example Okta deployment, once the app has been created, we can reference its client ID and the private key created for it without needing to touch the Okta API.