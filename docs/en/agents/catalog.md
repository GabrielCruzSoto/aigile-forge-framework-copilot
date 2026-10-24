# Declarative Agents Catalog (.github/agents/)

This document provides a comprehensive operational manual for the **11 Specialized GitHub Copilot Agents** integrated into **AFF-Copilot**, including agent configuration files, supported commands, input expectations, and output artifacts.

---

## 1. Agent Specialization Map

Each agent operates within a strictly defined responsibility perimeter to ensure focused context and eliminate hallucination:

```
                    ┌─────────────────────────┐
                    │    @aff-onboarding      │  <── Initial Cell Onboarding
                    └────────────┬────────────┘
                                 │
                    ┌────────────▼────────────┐
                    │    @aff-orchestrator    │  <── Governance & State Keeper
                    └────────────┬────────────┘
         ┌───────────────────────┼───────────────────────┐
         │                       │                       │
┌────────▼────────┐     ┌────────▼────────┐     ┌────────▼────────┐
│    @aff-pm      │     │  @aff-analyst   │     │ @aff-architect  │
│ (Elicitation)   │     │ (Specification) │     │ (Contracts/API) │
└────────┬────────┘     └────────┬────────┘     └────────┬────────┘
         │                       │                       │
┌────────▼────────┐     ┌────────▼────────┐     ┌────────▼────────┐
│  @aff-planner   │     │@aff-implementer │     │  @aff-security  │
│ (Atomic Tasks)  │     │  (TDD Loop)     │     │ (Audit & OWASP) │
└────────┬────────┘     └────────┬────────┘     └────────┬────────┘
         │                       │                       │
┌────────▼────────┐     ┌────────▼────────┐     ┌────────▼────────┐
│  @aff-reviewer  │     │    @aff-qa      │     │  @aff-curator   │
│  (4R Review)    │     │ (Test Receipts) │     │(Knowledge Base) │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

---

## 2. Exhaustive Agent Reference

### 1. `@aff-onboarding` — Initial Cell Bootstrapper
- **Configuration File:** [`.github/agents/aff-onboarding.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-onboarding.agent.md)
- **Primary Slash Command:** `/init-cell`
- **Role:** Leads the team through interactive elicitation across the 6 core dimensions of the cell (Identity, Roster, Enterprise, Business, Architecture, and WoW).
- **Inputs:** Interactive developer conversation or pre-filled templates from `templates/`.
- **Outputs:** `cell.config.yaml`, context documents in `knowledge/`, and `.github/instructions/cell-context.instructions.md`.

---

### 2. `@aff-orchestrator` — Governance & State Keeper
- **Configuration File:** [`.github/agents/aff-orchestrator.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-orchestrator.agent.md)
- **Commands:** `/aff-intake`, `/checkpoint`, `/resume`, `/status`
- **Role:** Governs the sprint state machine, enforces Human Gates, and manages context freezing and resumption.
- **Inputs:** Raw user tickets, interruption signals.
- **Outputs:** `sprints/state.yaml`, feature folder structure in `work/HU-XXX/`.

---

### 3. `@aff-pm` — Product Manager & Bilingual Elicitator
- **Configuration File:** [`.github/agents/aff-pm.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-pm.agent.md)
- **Commands:** `/elicit-ticket`, `/prepare-review`
- **Role:** Eliminates ambiguity in raw user stories by formulating hypotheses and up to 10 P1 refinement questions in both English and Spanish. Prepares sprint demo agendas.
- **Inputs:** `work/HU-XXX/ticket-raw.md`, PO refinement notes.
- **Outputs:** `work/HU-XXX/elicitation.md`, `work/HU-XXX/demo-script.md`.

---

### 4. `@aff-analyst` — Functional Analyst & DoR Hydrator
- **Configuration File:** [`.github/agents/aff-analyst.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-analyst.agent.md)
- **Commands:** `/answers-to-spec`, `/hu-to-tasks`
- **Role:** Translates refinement answers into concrete Given/When/Then acceptance criteria and validates the Definition of Ready (Gate G1).
- **Inputs:** `work/HU-XXX/elicitation.md` with PO answers.
- **Outputs:** `work/HU-XXX/spec.md`.

---

### 5. `@aff-architect` — Software Architect & Multi-Channel Parity Lead
- **Configuration File:** [`.github/agents/aff-architect.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-architect.agent.md)
- **Commands:** `/contract-first`, `/sync-mobile-web-parity`
- **Role:** Authors OpenAPI specifications, persistence strategies, and audits parity across Web, Android, and iOS channels (Gate G2).
- **Inputs:** `work/HU-XXX/spec.md`, architecture maps in `knowledge/`.
- **Outputs:** `work/HU-XXX/contract.md`, `work/HU-XXX/design.md`.

---

### 6. `@aff-planner` — Atomic Task Planner
- **Configuration File:** [`.github/agents/aff-planner.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-planner.agent.md)
- **Command:** `/plan-tasks`
- **Role:** Breaks down user stories into atomic, TDD-oriented tasks strictly capped at 400 lines of change per work unit.
- **Inputs:** `work/HU-XXX/spec.md`, `work/HU-XXX/contract.md`.
- **Outputs:** `work/HU-XXX/tasks.md`.

---

### 7. `@aff-implementer` — TDD Software Engineer
- **Configuration File:** [`.github/agents/aff-implementer.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-implementer.agent.md)
- **Commands:** `/implement-next`, `/debug-incident`
- **Role:** Implements production code adhering to the Red-Green-Refactor cycle directly inside connected code repositories.
- **Inputs:** `work/HU-XXX/tasks.md`, source codebase.
- **Outputs:** Code modifications, unit tests, and structured local git commits.

---

### 8. `@aff-reviewer` — Adversarial 4R Reviewer
- **Configuration File:** [`.github/agents/aff-reviewer.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-reviewer.agent.md)
- **Commands:** `/review-4r`, `/review-refuter`
- **Role:** Conducts comprehensive pre-PR code audits across four pillars (*Risk, Requirements, Regression, Resilience*) and refutes false positives.
- **Inputs:** Local `git diff`, `work/HU-XXX/spec.md`.
- **Outputs:** `work/HU-XXX/review.md` (Gate G3).

---

### 9. `@aff-qa` — Quality Assurance Engineer
- **Configuration File:** [`.github/agents/aff-qa.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-qa.agent.md)
- **Commands:** `/test-plan`, `/generate-receipt`
- **Role:** Authors comprehensive testing plans and consolidates automated/manual execution outputs into traceable Quality Receipts.
- **Inputs:** `work/HU-XXX/spec.md`, test execution logs.
- **Outputs:** `work/HU-XXX/test-plan.md`, `work/HU-XXX/evidence.md`.

---

### 10. `@aff-security` — Security & Compliance Auditor
- **Configuration File:** [`.github/agents/aff-security.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-security.agent.md)
- **Command:** `/security-check`
- **Role:** Enforces OWASP standards, zero-PII logging rules, database index mandates, cache TTL limits, and mobile secure storage policies.
- **Inputs:** Source code files, configuration files (`application.yaml`, Dockerfiles).
- **Outputs:** `work/HU-XXX/security-review.md`.

---

### 11. `@aff-curator` — Cell Knowledge Curator
- **Configuration File:** [`.github/agents/aff-curator.agent.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/.github/agents/aff-curator.agent.md)
- **Commands:** `/bootstrap-knowledge`, `/drift-check`
- **Role:** Audits knowledge drift between living code and documentation, archives finished user stories, and drafts Architectural Decision Records (ADRs).
- **Inputs:** Completed feature folders in `work/`, `knowledge/`.
- **Outputs:** `knowledge/adr/*.md`, `knowledge/drift-report.md`.

---

## 3. In-Chat Invocation Guide (VS Code)

To interact with an agent inside **GitHub Copilot Chat**:
1. Mention the agent handle and invoke the slash command:
   ```text
   @aff-architect /contract-first for transaction lookup endpoint
   ```
2. Reference multi-repository files across the workspace using `#file` or `@workspace`:
   ```text
   @aff-reviewer /review-4r comparing changes against #file:spec.md
   ```
