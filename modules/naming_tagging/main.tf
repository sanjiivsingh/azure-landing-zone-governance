resource "azurerm_policy_definition" "require_tag" {
  name                = "require-mandatory-tags"
  management_group_id = var.management_group_id
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Require mandatory enterprise tags on resources"
  description         = "Enforces existence of mandatory governance tags (Environment, Project, Owner, CostCenter) on resource creation."

  metadata = jsonencode({
    category = "Governance"
    version  = "1.0.0"
  })

  parameters = jsonencode({
    tagName = {
      type = "String"
      metadata = {
        displayName = "Mandatory Tag Name"
        description = "Name of the tag, such as Environment or CostCenter"
      }
    }
  })

  policy_rule = jsonencode({
    "if" = {
      field  = "[concat('tags[', parameters('tagName'), ']')]"
      exists = "false"
    }
    "then" = {
      effect = "deny"
    }
  })
}

resource "azurerm_policy_definition" "inherit_tag_from_rg" {
  name                = "inherit-tag-from-rg"
  management_group_id = var.management_group_id
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Inherit a tag from the resource group if missing"
  description         = "Adds or replaces the specified tag and value from the parent resource group when any resource is created without it."

  metadata = jsonencode({
    category = "Governance"
    version  = "1.0.0"
  })

  parameters = jsonencode({
    tagName = {
      type = "String"
      metadata = {
        displayName = "Tag Name to Inherit"
        description = "Name of the tag to inherit from Resource Group"
      }
    }
  })

  policy_rule = jsonencode({
    "if" = {
      allOf = [
        {
          field  = "[concat('tags[', parameters('tagName'), ']')]"
          exists = "false"
        },
        {
          value     = "[resourceGroup().tags[parameters('tagName')]]"
          notEquals = ""
        }
      ]
    }
    "then" = {
      effect = "modify"
      details = {
        roleDefinitionIds = [
          "/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
        ]
        operations = [
          {
            operation = "add"
            field     = "[concat('tags[', parameters('tagName'), ']')]"
            value     = "[resourceGroup().tags[parameters('tagName')]]"
          }
        ]
      }
    }
  })
}
