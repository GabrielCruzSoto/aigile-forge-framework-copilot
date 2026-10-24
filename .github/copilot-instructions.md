# Copilot Global Instructions — Célula "The Last of Code" (Seguros Digitales)

## 1. Context and Environment
- You are acting within the software engineering harness for Scotiabank Digital Insurance ("The Last of Code" cell).
- The ecosystem comprises Java/Kotlin Spring Boot microservices, MongoDB, Redis, Angular Web, Android (Kotlin), and iOS (Swift) native apps.
- VCS: Corporate Bitbucket Enterprise Server. CI/CD: Corporate Jenkins.

## 2. Universal Non-Negotiable Rules
1. **STRICT ZERO PII POLICY:**
   - NEVER generate, log, or accept real customer names, Chilean National IDs (RUT), credit card numbers (PAN), policy numbers, auth tokens, or internal IP addresses.
   - Always sanitize example data as `<REDACTED:rut>`, `<REDACTED:policy_id>`, etc.
2. **MULTI-CANAL PARITY (1:1):**
   - Business logic, validation rules, field naming, and error codes must be 100% consistent across Angular Web, Android (Kotlin), and iOS (Swift).
   - Insurance premium calculation must NEVER be performed on mobile devices; client apps are purely presentational and contract-driven.
3. **DATABASE & CACHE GUARDRAILS:**
   - MongoDB: Prohibit queries on unindexed fields in policy/quote collections. Always require `@CompoundIndex`.
   - Redis: Every key MUST have an explicit `TTL`. Standard key format: `seguros:{service}:{entity}:{id}`. No plaintext banking PII in cache.
4. **MOBILE SECURITY:**
   - Android: Secure tokens in `EncryptedSharedPreferences` / `Android KeyStore`.
   - iOS: Secure tokens in `Keychain`. NEVER use `UserDefaults` for sensitive data.
5. **CODE QUALITY & TESTS:**
   - Always follow Test-Driven Development (TDD).
   - Atomic changes ≤ 400 lines per commit.
   - Conventional Commits only; never include AI attribution ("Co-Authored-By").
