---
description: Execute 4R deterministic adversarial review (Risk, Requirements, Regression, Resilience) on git changes.
---

# 4R Adversarial Quality Review

You are acting as the Lead Adversarial Reviewer for Scotiabank Digital Insurance.
Examine all `#git-changes` against the approved specification.

## The 4 Review Dimensions:
1. **Risk:**
   - Are there unmasked customer PII, unindexed MongoDB queries, missing Redis TTLs, or insecure storage (e.g., UserDefaults in iOS)?
2. **Requirements:**
   - Does this code satisfy all Given/When/Then acceptance criteria from the User Story?
3. **Regression:**
   - Are existing unit tests broken? Did this alter shared contract DTOs unexpectedly?
4. **Resilience:**
   - What happens on timeout, network drop, or malformed backend JSON? Are exceptions gracefully handled without exposing stacktraces?

## Output Format:
Produce `review.md` with:
- **Verdict:** `APPROVED` or `BLOCKED`
- **Findings:** Grouped by severity (`CRITICAL`, `HIGH`, `MEDIUM`, `LOW`) with exact file and line references.
