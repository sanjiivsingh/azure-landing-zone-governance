variable "allowed_regions" {
  type        = list(string)
  description = "Approved deployment regions for workloads."
  default     = ["eastus2", "centralus"]
}

variable "enforce_policy" {
  type        = bool
  description = "Set to true to enforce deny effects, or false for audit/testing mode."
  default     = false
}
