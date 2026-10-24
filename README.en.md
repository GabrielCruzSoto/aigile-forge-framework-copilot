# Aigile Forge Framework — Copilot Declarative Edition (AFF-Copilot)
## Declarative AI-Assisted Software Engineering Framework for Enterprise Agile Cells

**Version:** 1.0.0  
**Base Harness:** Visual Studio Code Multi-Root Workspace + GitHub Copilot Business (100% Declarative)  
**Language:** English | [Versión en Español (README.md)](README.md)  
**Complete Documentation:** [Documentation Portal (docs/en/index.md)](docs/en/index.md)

---

## 1. Overview and Purpose

**AFF-Copilot** is an enterprise AI-assisted software engineering framework engineered for agile cells delivering multi-repository systems (Backend Microservices, Web Portals, and Native Mobile Apps) within regulated corporate environments.

The framework is **100% agnostic to any specific company, business domain, or team structure**. Rather than requiring static, hardcoded configuration files, it incorporates a dynamic **Initial Onboarding Agent (`@aff-onboarding`)** that allows any engineering cell to configure its operational environment in minutes.

It operates **purely declaratively** using the native capabilities of **GitHub Copilot in VS Code** (`.github/copilot-instructions.md`, `*.instructions.md`, `*.prompt.md`, `*.agent.md`, `@workspace`), **with zero external MCP servers, background daemon processes, or compiled binaries**.

### Architectural Pillars
1. **Initial Onboarding Agent (`@aff-onboarding`):** Dynamically elicits and synthesizes the cell's entire operational context: team identity, roster, enterprise compliance rules, business domain taxonomy, architecture maps, and ways of working.
2. **Zero Remote Footprint (Phases 0 & 1):** Uses a Multi-Root Workspace (`cell.code-workspace`) where local `.git/info/exclude` rules prevent accidental pollution of corporate remote repositories with local AI tooling.
3. **Multi-Channel Parity (1:1):** Enforces behavioral and data consistency between Web frontends and Native Mobile clients (Android and iOS), strictly prohibiting business rule calculations on client devices.
4. **Structured Bilingual Elicitation (ES / EN):** Clarifies incomplete user stories by formulating hypotheses and up to 10 P1 refinement questions with default recommended choices.
5. **Deterministic 4R Review with Adversarial Refuter:** Audits code increments across *Risk, Requirements, Regression, and Resilience* with a secondary refutation pass to eliminate false alarms.
6. **Enterprise Data & Security Guardrails:** Zero PII leakage in logs or agent memory, mandatory database indexing, and required cache TTL configurations.

---

## 2. Onboarding: Bootstrapping Your Cell Context

When initializing this framework for the first time, the **Onboarding Agent** guides you through context setup:

1. **Open the workspace in VS Code:**
   ```bash
   code cell.code-workspace
   ```
2. **Invoke the agent in Copilot Chat:**
   ```text
   @aff-onboarding /init-cell
   ```
3. **Complete the 6 Guided Dimensions:**
   - **Team Identity:** Cell name, slug, and linked repositories.
   - **Team Roster:** Member assignments (Tech Lead, PO, Backend/Frontend/Mobile devs, QA).
   - **Enterprise Information:** Organization, regulatory standards, repository hosting, and issue tracking.
   - **Business Domain:** Domain overview, key glossary terms, and quarterly objectives.
   - **Architecture & Stack:** Microservice catalog, databases, caches, and CI/CD pipelines.
   - **Ways of Working (WoW):** Ceremonies, sprint length, branch strategy (GitFlow/Trunk), and approval gates.

The agent automatically populates `cell.config.yaml`, generates `knowledge/` documents, and creates `.github/instructions/cell-context.instructions.md`.

---

## 3. Cell Lifecycle and Quality Control Gates

```text
[Sprint Backlog] ──> [/elicit-ticket] ──> [/answers-to-spec] ──> [Gate G1: DoR]
                                                                      │
[Gate G2: Contract/Parity] <── [/design & /sync-mobile-web-parity] <──┘
       │
       └──> [TDD Implementation in Repos] ──> [/review-4r & /review-refuter] ──> [Gate G3: PR]
                                                                                      │
[Sprint Review Demo] <── [/generate-receipt] <── [Gate G4: Release & Deploy] <────────┘
```

### Approval Gates
- **G1 (Definition of Ready - DoR):** Product Owner approves business criteria and clarifies P1 items; Technical Lead confirms architectural feasibility.
- **G2 (Contract & Channel Parity):** `contract.md` approval and 1:1 Web/Mobile parity verification prior to any client UI implementation.
- **G3 (Pull Request Approval):** Human peer code review backed by a favorable `/review-4r` audit and passing CI test suites.
- **G4 (Environment Promotion / Release):** Deployment verified by DevOps and the engineering team with a Quality Receipt.

---

## 4. Declarative Agents Catalog (.github/agents/)

| Custom Agent | Primary Slash Command | Specialized Focus |
|---|---|---|
| **`aff-onboarding`** | `/init-cell` | **Initial Agent:** Interactively bootstraps cell context across 6 dimensions. |
| **`aff-orchestrator`** | `/aff-intake`, `/checkpoint`, `/resume` | Governs the sprint hierarchy and maintains `state.yaml`. |
| **`aff-pm`** | `/elicit-ticket`, `/prepare-review` | Elicits requirements in ES/EN and prepares sprint review demo scripts. |
| **`aff-analyst`** | `/answers-to-spec`, `/hu-to-tasks` | Hydrates technical tasks and verifies Definition of Ready (G1). |
| **`aff-architect`** | `/contract-first`, `/sync-mobile-web-parity` | Designs REST contracts, persistence, caches, and audits multi-channel parity. |
| **`aff-security`** | `/security-check` | Audits OWASP standards, zero PII, database indexes, and keystore security. |
| **`aff-qa`** | `/test-plan`, `/generate-receipt` | Authors test plans and compiles verifiable Quality Receipts. |
| **`aff-curator`** | `/bootstrap-knowledge`, `/drift-check` | Keeps the knowledge base synchronized and drafts ADRs. |
| **`aff-planner`** | `/plan-tasks` | Decomposes features into atomic work units (≤ 400 lines of change). |
| **`aff-implementer`** | `/implement-next` | Strict TDD development cycle (Red-Green-Refactor) in local repositories. |
| **`aff-reviewer`** | `/review-4r`, `/review-refuter` | Adversarial 4R code review and false-positive refutation. |

---

## 5. Procedural Agent Skills Catalog (`skills/` & `.github/skills/`)

To prevent hallucination, each agent follows a **Procedural Agent Skill** defining inputs, step-by-step checklists, and acceptance criteria:

| Skill | Primary Agent | Key Deliverable | Methodology Highlights |
|---|---|---|---|
| **`cell-onboarding-bootstrap`** | `aff-onboarding` | `cell.config.yaml`, `knowledge/**` | 6-dimension interview and automated context generation. |
| **`bilingual-elicitation`** | `aff-pm` | `elicitation.md` | Hypothesis generation and max 10 P1 questions (ES/EN) with defaults. |
| **`spec-crafting-hydration`** | `aff-analyst` | `spec.md`, `task-cards/*.md` | Given/When/Then criteria with maturity rating and DoR validation. |
| **`contract-first-design`** | `aff-architect` | `contract.md`, `design.md` | OpenAPI schemas, synthetic mocks, and N/N-1 backwards compatibility. |
| **`multi-channel-parity`** | `aff-architect`, `aff-qa` | `contract.md#parity` | 1:1 consistency verification between Web, Android, and iOS channels. |
| **`adversarial-review-4r`** | `aff-reviewer` | `review.md` | 4-dimension audit (*Risk, Req, Reg, Res*) with refutation pass. |
| **`work-unit-tdd`** | `aff-planner`, `aff-implementer` | `tasks.md`, source code + tests | Atomic tasks ≤ 400 lines, Red-Green-Refactor cycle, and clean commits. |
| **`incident-rca-debugging`** | `aff-implementer`, `aff-analyst` | `rca.md`, failing test | Log analysis, reproducing red test, and 5-Whys root cause analysis. |
| **`pull-request-documentation`** | `aff-implementer`, `aff-reviewer` | `pr.md` | Traceable PR templates with impacts, release notes, and rollback steps. |
| **`test-evidence-receipts`** | `aff-qa` | `test-plan.md`, `evidence.md` | 1:1 requirement traceability and consolidated Quality Receipt. |
| **`enterprise-security-audit`** | `aff-security` | `security-review.md` | Zero PII, DB indexing, cache TTLs, and mobile Keystore audits. |
| **`knowledge-curation`** | `aff-curator` | `drift-report.md`, ADRs | Drift audits, pruning obsolete specs, and architectural decision records. |
| **`checkpoint-resume`** | `aff-orchestrator` | `state.yaml#checkpoint` | Work freezing in < 30s and frictionless resumption after interruptions. |

---

## 6. Local Setup and Quickstart

```bash
# 1. Verify development tools and VS Code extensions
./scripts/install-dependencies.sh

# 2. Configure local Git exclusions (.git/info/exclude), Skills, and Multi-Root
./scripts/setup-framework.sh

# Optional: Enable automated documentation backup to OneDrive
./scripts/setup-framework.sh --enable-onedrive "~/OneDrive - MyCompany/Cell-Docs"

# 3. Open the Multi-Root Workspace in VS Code
code cell.code-workspace

# 4. Run local pre-commit security and PII scan
./scripts/aff-secret-scan.sh

# 5. Check OneDrive sync status or trigger manual backup
./scripts/sync-onedrive.sh --status
./scripts/sync-onedrive.sh
```

### Automated OneDrive Synchronization (Optional)
- **What is synchronized:** `knowledge/`, `work/`, `sprints/`, `templates/`, `cell.config.yaml`, and root documentation.
- **What is strictly excluded:** `.git/`, source code repositories, `node_modules/`, binaries, and temporary files.
- **Mechanism:** A non-blocking Git `post-commit` hook triggers [`sync-onedrive.sh`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/scripts/sync-onedrive.sh) in the background after each commit in the hub.

---

## 7. Comprehensive Documentation Index

For an in-depth dive into each framework component, explore our detailed guides:

- [Main Documentation Portal (docs/en/index.md)](docs/en/index.md)
- [Technical Architecture & Multi-Root Setup (docs/en/architecture/overview.md)](docs/en/architecture/overview.md)
- [Step-by-Step Onboarding Guide (docs/en/guides/onboarding-setup.md)](docs/en/guides/onboarding-setup.md)
- [8-Phase Lifecycle & Human Quality Gates (docs/en/guides/lifecycle-and-gates.md)](docs/en/guides/lifecycle-and-gates.md)
- [Declarative Agents Reference Manual (docs/en/agents/catalog.md)](docs/en/agents/catalog.md)
- [Procedural Skills Catalog (docs/en/skills/catalog.md)](docs/en/skills/catalog.md)
- [Enterprise Security & OneDrive Synchronization (docs/en/governance/security-and-sync.md)](docs/en/governance/security-and-sync.md)
