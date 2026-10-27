resource "azurerm_policy_definition" "allowed_locations" {
  name                = "enforce-allowed-locations"
  management_group_id = var.management_group_id
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Enforce approved enterprise deployment regions"
  description         = "Restricts resource provisioning exclusively to pre-approved sovereign and cost-effective Azure regions."

  metadata = jsonencode({
    category = "Guardrails"
    version  = "1.0.0"
  })

  parameters = jsonencode({
    listOfAllowedLocations = {
      type = "Array"
      metadata = {
        displayName = "Allowed Locations"
        description = "List of approved Azure regions (e.g. eastus2, centralus)."
      }
    }
  })

  policy_rule = jsonencode({
    "if" = {
      allOf = [
        {
          field = "location"
          notIn = "[parameters('listOfAllowedLocations')]"
        },
        {
          field     = "location"
          notEquals = "global"
        },
        {
          field     = "type"
          notEquals = "Microsoft.AzureActiveDirectory/b2cDirectories"
        }
      ]
    }
    "then" = {
      effect = "deny"
    }
  })
}

resource "azurerm_policy_definition" "secure_storage" {
  name                = "require-secure-storage-baseline"
  management_group_id = var.management_group_id
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Enforce TLS 1.2+ and HTTPS for Azure Storage"
  description         = "Denies creation of Storage Accounts that allow plain HTTP traffic or TLS versions lower than 1.2."

  metadata = jsonencode({
    category = "Security"
    version  = "1.0.0"
  })

  policy_rule = jsonencode({
    "if" = {
      allOf = [
        {
          field  = "type"
          equals = "Microsoft.Storage/storageAccounts"
        },
        {
          anyOf = [
            {
              field     = "Microsoft.Storage/storageAccounts/supportsHttpsTrafficOnly"
              notEquals = true
            },
            {
              field     = "Microsoft.Storage/storageAccounts/minimumTlsVersion"
              notEquals = "TLS1_2"
            }
          ]
        }
      ]
    }
    "then" = {
      effect = "deny"
    }
  })
}
