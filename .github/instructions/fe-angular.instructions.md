---
applyTo: "**/*.{ts,html,scss}"
---

# Frontend Angular Instructions

## Architecture & Code Quality
1. **Strict TypeScript:**
   - Strict mode is enabled. The `any` type is strictly forbidden; always declare proper interfaces.
2. **Component Pattern:**
   - Smart (Container) / Presentational (Dumb) component architecture.
   - Use `ChangeDetectionStrategy.OnPush` across all presentational components.
3. **State & Subscriptions:**
   - Use Angular Signals for reactive local state where available.
   - Use `takeUntilDestroyed` or the `async` pipe in templates; prevent memory leaks.
4. **Security:**
   - Sanitize all dynamically rendered markup with `DomSanitizer`.
   - Never store unencrypted session tokens or insurance policy documents in `localStorage`.
