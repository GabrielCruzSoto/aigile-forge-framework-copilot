# Getting Started and Cell Onboarding Guide

This guide walks you through installing, configuring, and bootstrapping **AFF-Copilot** for your engineering team in enterprise environments.

---

## 1. Prerequisites

Before getting started, make sure your workstation meets the following requirements:
- **Visual Studio Code** (version 1.90 or later).
- **GitHub Copilot & GitHub Copilot Chat extensions** installed with an active enterprise or individual subscription.
- **Git** installed on the host system.
- **Shell Environment:** Native Bash on Linux/macOS, or Git Bash on Windows.

---

## 2. Step-by-Step Installation

### Step 1: Clone the Orchestration Repository
Clone the repository to your local machine (or within your agent workspace hub):
```bash
git clone <AFF_COPILOT_REPO_URL> aigile-forge-framework-copilot
cd aigile-forge-framework-copilot
```

### Step 2: Run Environment Diagnostics
Execute the diagnostic script to ensure your environment has the required CLI tools:
```bash
./scripts/install-dependencies.sh
```
The script automatically detects your operating system (Linux, macOS, or Windows via Git Bash/MSYS2) and verifies that `git`, `bash`, `code`, `sed`, `grep`, and the necessary VS Code extensions are available.

### Step 3: Initialize the Framework and Skills
Run the setup script:
```bash
./scripts/setup-framework.sh
```
This script performs three automated actions:
1. Creates local working directories (`knowledge/`, `work/`, `sprints/`, `archive/`).
2. Syncs and validates all **Agent Skills** from `skills/` to `.github/skills/`.
3. Sets up local Git exclusion rules in `.git/info/exclude`.

*(Optional: If your organization requires cell documentation to be backed up to Microsoft OneDrive, see the [Security & OneDrive Sync Guide](../governance/security-and-sync.md)).*

---

## 3. Connecting Source Code Repositories

Open [`cell.code-workspace`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/cell.code-workspace) and adjust the folder paths to reference your team's local git repositories:

```json
{
  "folders": [
    {
      "name": "⚙️ AFF - Framework Hub",
      "path": "."
    },
    {
      "name": "🌐 Backend - Microservices",
      "path": "../my-backend-service"
    },
    {
      "name": "💻 Frontend - Web App",
      "path": "../my-web-portal"
    },
    {
      "name": "📱 Mobile - App",
      "path": "../my-mobile-app"
    }
  ]
}
```

Then open the workspace in VS Code:
```bash
code cell.code-workspace
```

---

## 4. Interactive Onboarding with `@aff-onboarding`

Once inside VS Code, open **GitHub Copilot Chat** and run the onboarding slash command:

```text
@aff-onboarding /init-cell
```

The `@aff-onboarding` agent will initiate a structured interview to capture the **6 Core Dimensions of the Cell**:

```
                       ┌──────────────────────────────────────┐
                       │       @aff-onboarding /init-cell      │
                       └──────────────────┬───────────────────┘
                                          │
            ┌─────────────────────────────┼─────────────────────────────┐
            │                             │                             │
   1. TEAM IDENTITY              2. ROSTER & ROLES             3. ENTERPRISE & COMPLIANCE
   - Cell name                   - Product Owner               - Enterprise / Client
   - Operational slug            - Technical Lead              - Regulatory standards
   - Linked code repositories    - Devs (Back/Front/Mobile/QA) - Issue tracker (Jira/ADO)
            │                             │                             │
            ├─────────────────────────────┼─────────────────────────────┤
            │                             │                             │
   4. BUSINESS DOMAIN            5. ARCHITECTURE MAP           6. WAYS OF WORKING (WoW)
   - Domain taxonomy/glossary    - Microservices & APIs        - Sprint duration
   - Key quarterly goals         - Databases & caches          - Branch strategy (GitFlow)
   - Consumer channels           - Environments (Staging/Prod) - Definition of Done gates
            │                             │                             │
            └─────────────────────────────┴─────────────────────────────┘
                                          │
                                          ▼
                       ┌──────────────────────────────────────┐
                       │        GENERATED CELL ARTIFACTS      │
                       ├──────────────────────────────────────┤
                       │  • cell.config.yaml                  │
                       │  • knowledge/team-roster.md          │
                       │  • knowledge/business-overview.md    │
                       │  • knowledge/architecture-system.md  │
                       │  • knowledge/team-workflow.md        │
                       │  • .github/instructions/cell-context │
                       └──────────────────────────────────────┘
```

### Fast-Track Using Templates
If you already have your team's details documented, you can provide the answers directly or instruct the agent to populate using the templates in `templates/`:
- [`templates/cell.config.template.yaml`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/templates/cell.config.template.yaml)
- [`templates/team-roster.template.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/templates/team-roster.template.md)
- [`templates/business-overview.template.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/templates/business-overview.template.md)
- [`templates/architecture-system-map.template.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/templates/architecture-system-map.template.md)
- [`templates/team-workflow.template.md`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/templates/team-workflow.template.md)

---

## 5. Verifying the Onboarding Setup

Once the onboarding process concludes, verify that:
1. `cell.config.yaml` contains your team's actual settings.
2. The `knowledge/` directory contains business and architecture context free of sensitive credentials.
3. The file `.github/instructions/cell-context.instructions.md` is populated so that all 10 specialized engineering agents have immediate cell awareness.

Your team is now ready to kick off its first sprint using `@aff-orchestrator /aff-intake`!
