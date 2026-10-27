variable "management_group_id" {
  type        = string
  description = "Optional target Management Group ID for policy definition scope. If null, scope defaults to current subscription."
  default     = null
}
