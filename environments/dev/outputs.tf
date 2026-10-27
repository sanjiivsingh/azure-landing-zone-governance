output "policy_assignment_id" {
  description = "Resource ID of the applied subscription policy assignment."
  value       = azurerm_subscription_policy_assignment.baseline_assignment.id
}

output "governance_initiative_id" {
  description = "Resource ID of the deployed governance initiative."
  value       = module.initiatives.initiative_id
}
