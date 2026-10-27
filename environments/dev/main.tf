data "azurerm_subscription" "current" {}

module "naming_tagging" {
  source = "../../modules/naming_tagging"
}

module "guardrails" {
  source = "../../modules/guardrails"
}

module "initiatives" {
  source = "../../modules/initiatives"

  allowed_locations_policy_id = module.guardrails.allowed_locations_policy_id
  secure_storage_policy_id    = module.guardrails.secure_storage_policy_id
}

resource "azurerm_subscription_policy_assignment" "baseline_assignment" {
  name                 = "corp-governance-baseline"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = module.initiatives.initiative_id
  display_name         = "Corporate Governance Baseline (Dev)"
  description          = "Enforces region boundaries, mandatory tagging, and secure storage for dev subscriptions."
  enforce              = var.enforce_policy

  parameters = jsonencode({
    allowedRegions = {
      value = var.allowed_regions
    }
  })
}
