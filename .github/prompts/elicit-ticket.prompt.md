---
description: Formulate bilingual (ES/EN) hypotheses and max 10 P1 questions with defaults for Jira tickets with empty descriptions.
---

# Bilingual Elicitation for Jira User Stories

Given the User Story title and child task titles:

1. **Formulate Hypotheses:**
   - What business problem is Scotiabank solving with this feature?
   - Which insurance domains (life, fraud, vehicle, home) and microservices are touched?
2. **Generate Up to 10 P1 Questions (Bilingual ES/EN):**
   - Focus on essential unknowns that block development.
   - For every question, provide a concrete **Recommended Default Option**.
3. **Draft Target Architecture Impact:**
   - Identify backend microservices, MongoDB collections, and client channels impacted.

Output to `work/<HU-KEY>-<slug>/elicitation.md`.
