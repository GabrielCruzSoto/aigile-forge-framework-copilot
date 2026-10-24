---
applyTo: "**/*{Repository,Dao,Cache,Document,Redis,Mongo}*.{java,kt}"
---

# Database & Cache Guardrails: MongoDB & Redis

## MongoDB Rules
1. **Index Enforcement:**
   - Any query executing against transactional or core business collections MUST hit an existing indexed field.
   - Compound indexes must be declared on the `@Document` class via `@CompoundIndex` or index migration scripts.
2. **Projections & Updates:**
   - Always project only required fields for large documents (`fields = "{ 'entityId': 1, 'status': 1 }"`).
   - Use atomic `$set` operations rather than replacing entire documents.

## Redis Cache Rules
1. **TTL Requirement:**
   - Every cached entity MUST have an explicit Time-To-Live (`TTL`). Infinite keys are prohibited.
2. **Key Naming Convention:**
   - Format: `{cell}:{service}:{entity}:{id}` (e.g., `cell:order-service:order:12345`).
3. **No Plaintext PII:**
   - Sensitive customer data stored in cache must be hashed, masked, or encrypted.
