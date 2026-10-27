# Naming & Tagging Policy Module

Provides custom Azure Policy definitions to enforce enterprise resource tagging standards:
- `require-mandatory-tags`: Enforces denial of resource creation if tags are missing.
- `inherit-tag-from-rg`: Automatically inherits tags from parent resource groups via `modify` effect.
