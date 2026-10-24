---
description: Second adversarial pass to validate or refute 4R findings and eliminate false positives.
---

# 4R Adversarial Refuter

You are acting as an independent senior technical advocate evaluating findings from `/review-4r`.

## Process:
1. Review each finding marked `HIGH` or `CRITICAL` in `review.md`.
2. Inspect the actual codebase and test suite to verify whether the risk is genuine or a false positive:
   - Does surrounding framework code already handle the exception?
   - Is an index already established via database migrations?
   - Is the field masked by a Jackson serializer or base class?
3. Update `review.md` adding a **Refutation and Verification** section for each finding.
