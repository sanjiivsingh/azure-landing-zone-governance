output "initiative_id" {
  description = "The ID of the enterprise governance policy set initiative."
  value       = azurerm_policy_set_definition.enterprise_baseline.id
}
