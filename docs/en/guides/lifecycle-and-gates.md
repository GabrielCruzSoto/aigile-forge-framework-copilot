# 8-Phase Lifecycle & Human Quality Gates (G1 to G4)

This document describes the end-to-end operational lifecycle executed by development cells using **AFF-Copilot**, from initial feature intake to verified production deployment.

---

## 1. Lifecycle Workflow Diagram

```text
[Sprint Backlog]
       │
       ▼
 ┌───────────┐      ┌───────────────┐      ┌─────────────────┐     [ GATE G1 ]
 │  PHASE 1  │ ───> │    PHASE 2    │ ───> │     PHASE 3     │ ──> Definition of
 │  Intake   │      │  Elicitation  │      │ Analysis & DoR  │       Ready (DoR)
 └───────────┘      └───────────────┘      └─────────────────┘          │
                                                                        ▼
 ┌───────────┐      ┌───────────────┐      ┌─────────────────┐     [ GATE G2 ]
 │  PHASE 6  │ <─── │    PHASE 5    │ <─── │     PHASE 4     │ <── Contract &
 │  TDD Dev  │      │ Task Planning │      │ Contract Design │      Parity 1:1
 └─────┬─────┘      └───────────────┘      └─────────────────┘
       │
       ▼
 ┌───────────┐     [ GATE G3 ]      ┌───────────────┐     [ GATE G4 ]
 │  PHASE 7  │ ──> Pull Request ──> │    PHASE 8    │ ──> Deployment &
 │ Review 4R │     Approval         │ Delivery & QA │      Curation
 └───────────┘                      └───────────────┘
```

---

## 2. Exhaustive Phase Descriptions

### Phase 1: Intake & Ticket Capturing
- **Agent:** `@aff-orchestrator`
- **Command:** `/aff-intake`
- **Goal:** Ingest the raw user story or technical task from Jira/Azure DevOps, create the feature workspace under `work/HU-XXX/`, and register state tracking in `sprints/state.yaml`.
- **Artifact:** `work/HU-XXX/ticket-raw.md`.

### Phase 2: Structured Bilingual Elicitation
- **Agent:** `@aff-pm`
- **Command:** `/elicit-ticket`
- **Skill:** `bilingual-elicitation`
- **Goal:** Uncover functional ambiguities, unstated assumptions, and hidden dependencies. Formulate hypotheses and generate up to 10 P1 refinement questions in both English and Spanish with default recommended answers.
- **Artifact:** `work/HU-XXX/elicitation.md`.

### Phase 3: Functional Analysis & DoR Hydration
- **Agent:** `@aff-analyst`
- **Command:** `/answers-to-spec`
- **Skill:** `spec-crafting-hydration`
- **Goal:** Ingest the Product Owner's refinement responses, formalize acceptance criteria into Gherkin syntax (*Given / When / Then*), and assess readiness.
- **Artifact:** `work/HU-XXX/spec.md`.
- **🚪 GATE G1 (Definition of Ready - DoR):** The Product Owner and Technical Lead sign off on the specification. If critical business definitions are missing, work halts before design begins.

### Phase 4: Contract-First Design & Channel Parity
- **Agent:** `@aff-architect`
- **Commands:** `/contract-first`, `/sync-mobile-web-parity`
- **Skills:** `contract-first-design`, `multi-channel-parity`
- **Goal:** Design the REST/OpenAPI specification, JSON request/response schemas, database persistence models, and guarantee that Web, Android, and iOS consume identical business logic and error states.
- **Artifacts:** `work/HU-XXX/contract.md`, `work/HU-XXX/design.md`.
- **🚪 GATE G2 (Contract & Parity Approval):** Backend, frontend, and mobile engineers review the schema. No client-side implementation starts until the contract is ratified.

### Phase 5: Atomic Work Unit Planning
- **Agent:** `@aff-planner`
- **Command:** `/plan-tasks`
- **Skill:** `work-unit-tdd`
- **Goal:** Decompose the feature into small, atomic work units optimized for TDD, strictly capped at 400 lines of change per task to ensure rapid, thorough peer reviews.
- **Artifact:** `work/HU-XXX/tasks.md`.

### Phase 6: Implementation via TDD Cycle
- **Agent:** `@aff-implementer`
- **Command:** `/implement-next`
- **Skill:** `work-unit-tdd`
- **Goal:** Implement the active task adhering to the strict **Red-Green-Refactor** pattern:
  1. *Red:* Author a failing unit or integration test.
  2. *Green:* Implement the minimal code required to make tests pass.
  3. *Refactor:* Clean up structure and eliminate smells while preserving green suites.
- **Artifact:** Modified source code, automated test suites, and clean local git commits in the targeted code repository.

### Phase 7: Adversarial 4R Review & Refutation
- **Agent:** `@aff-reviewer`
- **Commands:** `/review-4r`, `/review-refuter`
- **Skill:** `adversarial-review-4r`
- **Goal:** Audit the code changes across four dimensions prior to Pull Request submission:
  - **Risk:** PII exposure, OWASP vulnerabilities, resource leaks.
  - **Requirements:** Strict compliance with `spec.md` Given/When/Then scenarios.
  - **Regression:** Impact on existing modules and branch test coverage.
  - **Resilience:** Defensive error handling, timeout management, and transactions.
  - **Refutation:** A second adversarial pass to challenge findings and eliminate false positives.
- **Artifact:** `work/HU-XXX/review.md`.
- **🚪 GATE G3 (Pull Request Approval & Merge):** The PR in the target code repository is reviewed by human engineers, supported by the 4R report and passing CI pipelines.

### Phase 8: Evidence Receipts, Delivery & Knowledge Curation
- **Agents:** `@aff-qa`, `@aff-curator`
- **Commands:** `/generate-receipt`, `/bootstrap-knowledge`
- **Skills:** `test-evidence-receipts`, `knowledge-curation`
- **Goal:** Consolidate automated and manual test receipts, prepare the sprint review demo script, archive completed work, and update the persistent knowledge base (`knowledge/`).
- **Artifacts:** `work/HU-XXX/evidence.md`, `knowledge/architecture-system-map.md`.
- **🚪 GATE G4 (Release & Production Deployment):** Final sign-off for staging promotion and subsequent production rollout.

---

## 3. Human Quality Gates Matrix

**Human Gates** are non-delegable control points where designated human roles must provide explicit authorization:

| Gate | Name | Responsible Role | Acceptance Criteria | Key Artifact |
|---|---|---|---|---|
| **G1** | **Definition of Ready (DoR)** | Product Owner & Tech Lead | Zero open P1 questions; complete Given/When/Then criteria. | `work/HU-XXX/spec.md` |
| **G2** | **Contract & Parity** | Tech Lead & Channel Devs | Validated OpenAPI schema; 1:1 Web/Mobile parity certified. | `work/HU-XXX/contract.md` |
| **G3** | **Pull Request Approval** | Tech Lead & Peer Reviewer | Clean 4R verdict; green CI build; no out-of-scope changes. | `work/HU-XXX/review.md` |
| **G4** | **Release & Production** | DevOps, PO & QA | Complete Quality Receipt; successful smoke tests. | `work/HU-XXX/evidence.md` |

---

## 4. Work Freezing and Resumption (`checkpoint-resume`)

When a developer experiences an urgent priority shift, meeting, or context interruption:

1. **Freeze Active Work (< 30s):**
   ```text
   @aff-orchestrator /checkpoint
   ```
   Captures active branch status, modified files, and current task state in `sprints/state.yaml`.
2. **Resume Work Frictionlessly:**
   ```text
   @aff-orchestrator /resume
   ```
   Restores context, verifies git branches across repositories, and presents the next pending action from `tasks.md`.
