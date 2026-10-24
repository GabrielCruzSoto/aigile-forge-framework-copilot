# Copilot Global Instructions — Enterprise Agile Cell Harness

## 1. Context and Dynamic Cell Identity
- You are acting within the declarative engineering harness for agile multi-repo enterprise cells.
- The active cell profile, team roster, company standards, business domain, and architecture map are defined in `cell.config.yaml` and loaded via the `aff-onboarding` agent.
- Tech stack baseline: Backend microservices (Java/Kotlin, Node or Go), Frontend Web, Mobile Native apps (Android/iOS), Databases/Cache, and Enterprise CI/CD pipelines.

## 2. Universal Non-Negotiable Rules
1. **STRICT ZERO PII & CONFIDENTIALITY POLICY:**
   - NEVER generate, log, or accept real customer names, national identification numbers, credit card numbers (PAN), account numbers, auth tokens, or private enterprise network endpoints.
   - Always sanitize example data using synthetic placeholders: `<REDACTED:id>`, `<REDACTED:token>`, `<REDACTED:account>`.
2. **MULTI-CANAL PARITY (1:1):**
   - Business validation rules, field naming conventions, and error codes must maintain 100% parity across Web and Mobile Native applications.
   - Core domain and pricing calculations must NEVER be performed on mobile/client devices; client applications must remain purely contract-driven.
3. **DATABASE & CACHE GUARDRAILS:**
   - Document Databases: Prohibit queries on unindexed fields in transactional collections. Compound indexes must be explicitly documented and declared.
   - Cache Stores: Every key MUST define an explicit `TTL`. Standard key format: `{cell}:{service}:{entity}:{id}`. Cero plaintext confidential PII in cache.
4. **MOBILE SECURITY:**
   - Android: Store authentication tokens and sensitive values in `EncryptedSharedPreferences` backed by `Android KeyStore`.
   - iOS: Store authentication tokens and sensitive values in `Keychain Services`. Strictly FORBIDDEN to use `UserDefaults` for security-sensitive data.
5. **CODE QUALITY & TESTS:**
   - Always adhere to Test-Driven Development (TDD: Red-Green-Refactor).
   - Atomic changes ≤ 400 lines per commit.
   - Conventional Commits only; never include AI attribution ("Co-Authored-By").
