resource "azurerm_policy_set_definition" "enterprise_baseline" {
  name         = "enterprise-governance-baseline"
  policy_type  = "Custom"
  display_name = "Enterprise Landing Zone Governance Baseline"
  description  = "Initiative combining location controls, mandatory tagging, and storage transport encryption."

  metadata = jsonencode({
    category = "Governance"
    version  = "1.0.0"
  })

  parameters = jsonencode({
    allowedRegions = {
      type = "Array"
      metadata = {
        displayName = "Approved Deployment Regions"
        description = "List of approved Azure regions"
      }
    }
  })

  policy_definition_reference {
    policy_definition_id = var.allowed_locations_policy_id
    parameter_values = jsonencode({
      listOfAllowedLocations = {
        value = "[parameters('allowedRegions')]"
      }
    })
    reference_id = "allowedLocationsRef"
  }

  policy_definition_reference {
    policy_definition_id = var.secure_storage_policy_id
    reference_id         = "secureStorageRef"
  }
}
