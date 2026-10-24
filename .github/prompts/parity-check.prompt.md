---
description: Audit 1:1 multi-channel parity across Angular Web, Android (Kotlin), and iOS (Swift).
---

# Multi-Channel Parity Check (Web vs Android vs iOS)

Compare the client implementations in `@workspace` against `contract.md`.

## Verification Dimensions:
1. **JSON Payload Parity:**
   - Are the property keys identical (camelCase) across all client apps?
2. **Validation Logic:**
   - Are client-side form validation rules (e.g., ID checksum, email pattern, phone length) identical?
3. **Zero Core Domain Logic:**
   - Confirm that neither Android nor iOS contains local core business/pricing calculation logic.
4. **Error Code Mapping:**
   - Are HTTP 4xx/5xx errors mapped to consistent user messages across all platforms?

## Output:
Produce the Parity Audit Matrix in `contract.md#parity`.
