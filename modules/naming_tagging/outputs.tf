output "require_tag_policy_id" {
  description = "The ID of the require mandatory tag policy definition."
  value       = azurerm_policy_definition.require_tag.id
}

output "inherit_tag_policy_id" {
  description = "The ID of the inherit tag from RG policy definition."
  value       = azurerm_policy_definition.inherit_tag_from_rg.id
}
