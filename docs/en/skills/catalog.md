# Procedural Skills Catalog (skills/)

This document details the **13 Procedural Agent Skills** integrated into **AFF-Copilot**. Each skill defines a deterministic, step-by-step workflow that guides AI agents to produce rigorous engineering deliverables without hallucination.

---

## 1. Skill Anatomy & Architecture

Every skill resides in its dedicated directory under [`skills/`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/skills/) and is automatically mirrored into [`.github/skills/`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/skills/) for native Copilot access.

A standard `SKILL.md` contains:
```markdown
---
name: skill-name
description: Concise description of when and how this skill is applied.
---

# Skill Title

## 1. Purpose and Activation Triggers
## 2. Required Input Context
## 3. Step-by-Step Procedure (Actionable Checklist)
## 4. Deliverables and Output File Structure
## 5. Acceptance Criteria and Common Gotchas
```

---

## 2. The 13 Procedural Agent Skills

### 1. `cell-onboarding-bootstrap`
- **Lead Agent:** `@aff-onboarding`
- **Deliverables:** `cell.config.yaml`, `knowledge/*.md`, `.github/instructions/cell-context.instructions.md`.
- **Procedure:** Conducts the structured 6-dimension interview (Identity, Roster, Enterprise, Business, Architecture, WoW). Sanitizes sensitive parameters and generates cell foundation files.

---

### 2. `bilingual-elicitation`
- **Lead Agent:** `@aff-pm`
- **Deliverable:** `work/HU-XXX/elicitation.md`.
- **Procedure:** Analyzes incomplete or draft requirements and generates up to 10 P1 refinement questions in both English and Spanish. Each question includes suggested defaults to minimize back-and-forth friction.

---

### 3. `spec-crafting-hydration`
- **Lead Agent:** `@aff-analyst`
- **Deliverables:** `work/HU-XXX/spec.md`, `work/HU-XXX/task-cards/*.md`.
- **Procedure:** Processes business refinement inputs and codifies formal acceptance criteria in Gherkin (*Given / When / Then*) syntax. Calculates Definition of Ready score (Gate G1).

---

### 4. `contract-first-design`
- **Lead Agent:** `@aff-architect`
- **Deliverables:** `work/HU-XXX/contract.md`, `work/HU-XXX/design.md`.
- **Procedure:** Drafts OpenAPI/REST contracts, data models, HTTP status codes, and persistence mechanisms. Validates backwards compatibility (N / N-1).

---

### 5. `multi-channel-parity`
- **Lead Agents:** `@aff-architect`, `@aff-qa`
- **Deliverable:** Parity verification section in `work/HU-XXX/contract.md`.
- **Procedure:** Audits contracts for 1:1 behavioral parity across Web (Angular/React) and Mobile (Android Kotlin / iOS Swift). Ensures business calculations are strictly server-side.

---

### 6. `adversarial-review-4r`
- **Lead Agent:** `@aff-reviewer`
- **Deliverable:** `work/HU-XXX/review.md`.
- **Procedure:** Audits git diffs across four dimensions (*Risk, Requirements, Regression, Resilience*) followed by an adversarial refuter pass to challenge claims and discard false alarms.

---

### 7. `work-unit-tdd`
- **Lead Agents:** `@aff-planner`, `@aff-implementer`
- **Deliverables:** `work/HU-XXX/tasks.md`, source code, and unit tests.
- **Procedure:** Splits user stories into atomic tasks (≤ 400 lines of change). Executes the strict Red-Green-Refactor loop: failing test first, minimal green implementation second, refactoring third.

---

### 8. `incident-rca-debugging`
- **Lead Agents:** `@aff-implementer`, `@aff-analyst`
- **Deliverables:** `work/HU-XXX/rca.md`, reproducing failing regression test.
- **Procedure:** Production incident response protocol. Uses the *5 Whys* methodology, pinpoints anomalies in logs, and authors a failing automated regression test prior to making any code edits.

---

### 9. `pull-request-documentation`
- **Lead Agents:** `@aff-implementer`, `@aff-reviewer`
- **Deliverable:** `work/HU-XXX/pr.md`.
- **Procedure:** Authors comprehensive, traceable Pull Request descriptions with executive summaries, linked tickets, verification evidence, rollback procedures, and changelog entries.

---

### 10. `test-evidence-receipts`
- **Lead Agent:** `@aff-qa`
- **Deliverables:** `work/HU-XXX/test-plan.md`, `work/HU-XXX/evidence.md`.
- **Procedure:** Defines the complete test matrix (unit, integration, e2e). Captures test execution outputs and issues a verifiable Quality Receipt for release authorization (Gate G4).

---

### 11. `enterprise-security-audit`
- **Lead Agent:** `@aff-security`
- **Deliverable:** `work/HU-XXX/security-review.md`.
- **Procedure:** Enforces zero plaintext credentials, zero PII logging, mandatory database indexes on queried fields, and required TTLs on cache keys.

---

### 12. `knowledge-curation`
- **Lead Agent:** `@aff-curator`
- **Deliverables:** `knowledge/drift-report.md`, ADRs under `knowledge/adr/`.
- **Procedure:** Periodically reconciles living code against documentation in `knowledge/`. Flags obsolete specifications, archives completed feature folders, and records major architectural decisions.

---

### 13. `checkpoint-resume`
- **Lead Agent:** `@aff-orchestrator`
- **Deliverable:** Checkpoint state section in `sprints/state.yaml`.
- **Procedure:** Freezes work in progress in under 30 seconds by snapshotting git branch names, modified files, and pending task checklists, allowing instant resumption after context switches.
