# Technical Architecture & Declarative Harness Model

This document details the core architectural foundations and internal harness design of **Aigile Forge Framework — Copilot Declarative Edition (AFF-Copilot)**.

---

## 1. Architectural Vision

AFF-Copilot addresses a critical enterprise challenge in AI-assisted software engineering: **how to guide cross-functional teams in complex multi-repository systems without requiring fragile local servers, heavy plugins, or altering corporate repository structures.**

```
┌────────────────────────────────────────────────────────────────────────┐
│                   VS CODE MULTI-ROOT WORKSPACE                         │
│                      (cell.code-workspace)                             │
├───────────────────────────────┬────────────────────────────────────────┤
│  ORCHESTRATION REPO (AFF)     │       SOURCE CODE REPOSITORIES         │
│  (Governance Hub & Memory)    │         (Active Development)           │
│                               │                                        │
│  ├── cell.config.yaml         │  ├── repo-backend-ms/ (Spring Boot/Go) │
│  ├── knowledge/ (Domain/Arch) │  ├── repo-frontend-web/ (Angular/React)│
│  ├── work/ (HU/Spikes/Specs)  │  ├── repo-mobile-android/ (Kotlin)     │
│  ├── sprints/ (Checkpoints)   │  └── repo-mobile-ios/ (Swift)          │
│  ├── .github/                 │                                        │
│  │   ├── agents/*.agent.md    │                                        │
│  │   ├── prompts/*.prompt.md  │                                        │
│  │   └── skills/**            │                                        │
│  └── scripts/                 │                                        │
└───────────────────────────────┴────────────────────────────────────────┘
```

The framework functions as a **Centralized Orchestration Hub**. All governance artifacts, interface contracts, feature specifications, and audit trails reside in the AFF workspace, while production code is manipulated directly within its respective source code repositories.

---

## 2. Multi-Root Workspace Pattern

Rather than forcing an artificial monorepo or cloning repositories as nested git submodules, the framework leverages Visual Studio Code's native **Multi-Root Workspaces** (`cell.code-workspace`).

### Key Benefits:
1. **Unified `@workspace` Visibility:** GitHub Copilot gains comprehensive, simultaneous contextual awareness across backend services, frontend portals, mobile clients, and framework specifications.
2. **Repository Autonomy:** Each code repository preserves its independent Git commit history, active branches, remotes (`origin`), access permissions, and CI/CD pipelines.
3. **Zero Remote Footprint:** Framework configuration directories (`.github/`, `knowledge/`, `cell.config.yaml`) are never committed or pushed to corporate code repositories.

### Workspace Configuration (`cell.code-workspace`):
```json
{
  "folders": [
    {
      "name": "⚙️ AFF - Framework Hub",
      "path": "."
    },
    {
      "name": "🌐 Backend - Microservices",
      "path": "../repo-backend-ms"
    },
    {
      "name": "💻 Frontend - Web App",
      "path": "../repo-frontend-web"
    },
    {
      "name": "📱 Mobile - Android Native",
      "path": "../repo-mobile-android"
    },
    {
      "name": "🍏 Mobile - iOS Native",
      "path": "../repo-mobile-ios"
    }
  ],
  "settings": {
    "github.copilot.chat.scope": "workspace",
    "files.exclude": {
      "**/.git": false
    }
  }
}
```

---

## 3. Local Isolation: Zero Remote Footprint (`.git/info/exclude`)

In corporate environments governed by strict compliance policies, committing AI tooling or local orchestrator files directly into production branches is prohibited during early pilot phases.

To enforce compliance, the [`aigile-copilot`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/aigile-copilot) assistant automatically appends framework patterns to `.git/info/exclude` in each linked repository. Unlike `.gitignore`, `.git/info/exclude` **is never committed or pushed upstream**, keeping all agent orchestration artifacts strictly private to the developer's workstation.

---

## 4. 100% Declarative GitHub Copilot Harness

Unlike agent frameworks that rely on fragile MCP servers or memory-heavy daemon processes, AFF-Copilot is **100% declarative**. It operates using the standard primitives supported natively by GitHub Copilot and VS Code:

| Component | Workspace Path | Architectural Role |
|---|---|---|
| **Custom Agents** | `.github/agents/*.agent.md` | Encapsulates specialized roles, responsibilities, ethical boundaries, and available tools. |
| **Slash Prompts** | `.github/prompts/*.prompt.md` | Exposes executable chat actions (`/init-cell`, `/elicit-ticket`, `/review-4r`). |
| **Instructions** | `.github/copilot-instructions.md`, `.github/instructions/*.instructions.md` | Injects persistent, non-negotiable architectural rules into every interaction context. |
| **Agent Skills** | `skills/*/SKILL.md` and `.github/skills/*/SKILL.md` | Provides deterministic, step-by-step procedures and quality checklists to prevent hallucination. |

---

## 5. Multi-Channel Parity as an Architectural Mandate

In omnichannel products, discrepancies between Web applications and Mobile clients (iOS & Android) represent a major source of production defects and customer friction.

AFF-Copilot institutes **Multi-Channel Parity (1:1)**:
- **Canonical API Contract (`contract.md`):** All endpoints and JSON models must behave identically across client channels.
- **Backend-Enforced Validation:** Business rules, credit scoring, discount calculations, and eligibility policies are strictly computed by backend services. Client applications purely render states and handle presentation.
- **Consistent Error Taxonomy:** Both Web and Mobile apps react to standardized domain error codes (`ERR_INSUFFICIENT_FUNDS`, `ERR_SESSION_TIMEOUT`) using unified customer interaction flows.

---

## 6. Directory Structure & Layout

```
aigile-forge-framework-copilot/
├── cell.code-workspace         # Multi-Root workspace definition
├── cell.config.yaml            # Cell configuration generated during onboarding
├── AGENTS.md                   # Master agent contract and operational catalog
├── README.md                   # Spanish overview and quickstart
├── README.en.md                # English overview and quickstart
├── docs/                       # Complete documentation suite
│   ├── es/                     # Spanish guides and reference manuals
│   └── en/                     # English guides and reference manuals
├── knowledge/                  # Persistent cell knowledge base
│   ├── business-overview.md    # Business domain and key glossary terms
│   ├── team-roster.md          # Team members and role assignments
│   ├── architecture-system-map.md # Component maps, databases, and APIs
│   └── team-workflow.md        # Sprint ceremonies, branch model, and DoD
├── work/                       # Active sprint backlog and feature cards
│   └── HU-XXX/                 # Feature folder (spec.md, contract.md, review.md)
├── sprints/                    # Sprint tracking and state checkpoints
├── skills/                     # Canonical store of the 13 Agent Skills
├── .github/                    # Declarative configuration hub for Copilot
│   ├── agents/                 # The 11 specialized agent personas
│   ├── prompts/                # Chat slash commands
│   ├── instructions/           # Contextual instructions
│   └── skills/                 # Mirrored skills accessible to Copilot
├── aigile-copilot              # Unified diagnostics & scaffolding CLI assistant
└── scripts/                    # Cross-platform automation and audit scripts
    ├── sync-onedrive.sh        # Optional OneDrive documentation backup
    └── aff-secret-scan.sh      # Pre-commit secret and PII scanner
```
