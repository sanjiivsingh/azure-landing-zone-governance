# Architecture Specification: Azure Governance Landing Zone

## Overview
This landing zone codifies enterprise guardrails and resource tagging compliance across subscriptions adhering to the **Microsoft Cloud Adoption Framework (CAF)**.

## Key Design Decisions
1. **Initiative Grouping:** Individual policy definitions are aggregated into an Enterprise Governance Initiative to simplify assignment and reporting.
2. **Graceful Enforcement:** Provides `enforce_policy` boolean parameter. Recommended workflow starts in Audit mode (`enforce_policy = false`) for existing workloads before switching to Deny mode.
3. **Zero Secret Footprint:** Uses managed identities and Azure OIDC federation for CI/CD pipeline deployments.
