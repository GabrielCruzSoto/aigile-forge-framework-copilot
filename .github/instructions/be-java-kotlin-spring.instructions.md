---
applyTo: "**/*.{java,kt}"
---

# Backend Java & Kotlin Spring Boot Instructions

## Standards for Backend Services
1. **JDK Version:** Java 17 or Java 21. Spring Boot 3.x using `jakarta.*` namespace.
2. **Kotlin Guidelines:**
   - Strict null-safety: strictly FORBIDDEN to use the non-null assertion operator `!!`.
   - Use `data class` for DTOs and value objects.
   - Use Kotlin Coroutines / Flow for asynchronous processing.
3. **Java Guidelines:**
   - Use Java records for immutable request/response DTOs.
   - Constructor injection only; do not use field-level `@Autowired`.
4. **Error Handling:**
   - Implement `@RestControllerAdvice` returning RFC 7807 compliant problem details with correlation ID.
   - Never expose raw stacktraces or internal database error messages to HTTP clients.
