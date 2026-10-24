---
applyTo: "**"
---

# Enterprise Security Instructions

## Mandatory Compliance Rules
1. **Zero Customer PII & Confidential Data:**
   - Prohibited to output or persist real national IDs, credit card numbers (PAN), customer passwords, personal session tokens, or real commercial identifiers.
   - Use synthetic tokens: `ID-MOCK-12345678-9`, `PAN-MOCK-4111111111111111`.
2. **Infrastructure Isolation:**
   - Never execute or suggest commands accessing production clusters (`kubectl`, `argocd`, `helm`) directly.
   - All diagnostic traces must be sanitized before ingestion.
3. **Traceability:**
   - Ensure all network and API calls forward standard correlation headers (`X-Correlation-Id`, `X-Trace-Id`).
