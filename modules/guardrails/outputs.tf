output "allowed_locations_policy_id" {
  description = "The ID of the allowed locations policy definition."
  value       = azurerm_policy_definition.allowed_locations.id
}

output "secure_storage_policy_id" {
  description = "The ID of the secure storage policy definition."
  value       = azurerm_policy_definition.secure_storage.id
}
