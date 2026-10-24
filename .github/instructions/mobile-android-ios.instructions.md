---
applyTo: "**/*.{kt,xml,swift,m,h}"
---

# Mobile Native Instructions (Android Kotlin & iOS Swift)

## Multi-Channel Paridad Rules
1. **Zero Premium Calculation on Clients:**
   - Calculation of insurance rates, coverage amounts, and premium totals must ALWAYS be evaluated by backend microservices.
   - Client apps are responsible only for displaying backend values and submitting customer choices.
2. **Field Parity:**
   - JSON payload property names and error codes must match 1:1 with Web Angular contracts.

## Android Native Standards (Kotlin)
- Architecture: MVVM + Repository pattern with Clean Architecture separation.
- Async: Coroutines and `StateFlow` / `SharedFlow`.
- Security: Store access tokens in `EncryptedSharedPreferences` backed by `Android KeyStore`.

## iOS Native Standards (Swift)
- Architecture: MVVM with Swift modern concurrency (`async/await`) or Combine.
- Memory: Weak references on closures (`[weak self]`) to prevent retain cycles.
- Security: Store access tokens and sensitive data in `Keychain Services`. Strictly FORBIDDEN to use `UserDefaults` for security-sensitive data.
