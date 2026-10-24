---
applyTo: "**"
---

# Banking Security Instructions

## Mandatory Compliance Rules
1. **Zero Customer PII:**
   - Prohibited to output or persist real RUTs, credit card numbers, passwords, session tokens, or real insurance policy numbers.
   - Use synthetic tokens: `RUT-MOCK-12345678-9`, `PAN-MOCK-4111111111111111`.
2. **Infrastructure Isolation:**
   - Never execute or suggest commands accessing production clusters (`kubectl`, `argocd`, `helm`) directly.
   - All diagnostic traces must be sanitized before ingestion.
3. **Traceability:**
   - Ensure all network and API calls forward banking correlation IDs (`X-Correlation-Id`, `X-B3-TraceId`).
