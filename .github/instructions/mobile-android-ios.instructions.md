---
applyTo: "**/*.{kt,xml,swift,m,h}"
---

# Mobile Native Instructions (Android Kotlin & iOS Swift)

## Multi-Channel Parity Rules
1. **Zero Core Domain Calculation on Clients:**
   - Calculation of core business rules, fees, pricing, and transactional totals must ALWAYS be evaluated by backend services.
   - Client applications are responsible only for displaying backend values and submitting user choices.
2. **Field Parity:**
   - JSON payload property names and error codes must match 1:1 with Web contracts.

## Android Native Standards (Kotlin)
- Architecture: MVVM + Repository pattern with Clean Architecture separation.
- Async: Coroutines and `StateFlow` / `SharedFlow`.
- Security: Store access tokens in `EncryptedSharedPreferences` backed by `Android KeyStore`.

## iOS Native Standards (Swift)
- Architecture: MVVM with Swift modern concurrency (`async/await`) or Combine.
- Memory: Weak references on closures (`[weak self]`) to prevent retain cycles.
- Security: Store access tokens and sensitive data in `Keychain Services`. Strictly FORBIDDEN to use `UserDefaults` for security-sensitive data.
