# Aigile Forge Framework — Copilot Edition (AFF-Copilot) Documentation

Welcome to the official documentation for **Aigile Forge Framework — Copilot Declarative Edition (AFF-Copilot)**.

AFF-Copilot is a declarative, AI-assisted software engineering framework engineered for **enterprise agile cells** operating on multi-repository architectures (Backend Microservices, Web Frontend, and Native Mobile Apps for iOS/Android).

---

## 🗺️ Documentation Map

This documentation is organized into four modular areas:

```
docs/en/
├── index.md                              # This portal document
├── architecture/
│   └── overview.md                       # Technical architecture, Multi-Root & declarative harness
├── guides/
│   ├── onboarding-setup.md               # Step-by-step cell initialization guide
│   └── lifecycle-and-gates.md            # 8-phase lifecycle & the 4 Human Gates (G1 - G4)
├── agents/
│   └── catalog.md                        # Comprehensive manual of the 11 declarative Copilot agents
├── skills/
│   └── catalog.md                        # Procedural catalog of the 13 Agent Skills
└── governance/
    └── security-and-sync.md              # Enterprise security guardrails & OneDrive sync
```

---

## 🚀 Core Framework Principles

1. **100% Declarative and Native:** Operates directly inside Visual Studio Code using native GitHub Copilot Business features (`.github/agents/`, `.github/prompts/`, `.github/instructions/`, `.github/skills/`). No MCP servers, background daemon processes, or compiled binaries required.
2. **Agnostic and Dynamic:** Contains zero hardcoded company, business, or team references. Cell identity is synthesized interactively via the `@aff-onboarding` agent and the `/init-cell` command.
3. **Zero Remote Footprint:** The framework resides in its own orchestration hub repository and connects to code repositories via a Multi-Root Workspace (`cell.code-workspace`). Local configurations are insulated using `.git/info/exclude`.
4. **Multi-Channel Parity (1:1):** Enforces strict consistency across data contracts, validation rules, and error codes between Web (Angular/React) and Mobile (Android Kotlin / iOS Swift).
5. **Deterministic 4R Quality:** Every code increment is audited against four dimensions (*Risk, Requirements, Regression, Resilience*) with an adversarial refutation phase prior to Pull Request submission.

---

## 📚 Recommended Reading Paths

- **For Software Engineers and QA:**
  1. [Getting Started and Onboarding Guide](guides/onboarding-setup.md)
  2. [8-Phase Lifecycle & Quality Gates](guides/lifecycle-and-gates.md)
  3. [Agent Skills Catalog](skills/catalog.md)

- **For Technical Leads and Architects:**
  1. [Framework Architecture & Multi-Root Setup](architecture/overview.md)
  2. [Declarative Agents Catalog](agents/catalog.md)
  3. [Enterprise Security & OneDrive Sync](governance/security-and-sync.md)

- **For Product Owners and Scrum Masters:**
  1. [Cell Onboarding & Bilingual Elicitation](guides/onboarding-setup.md)
  2. [Quality Control Gates (G1 to G4)](guides/lifecycle-and-gates.md)

---

> 🌐 **Versión en Español:** Puedes acceder a la documentación completa en español en [`docs/es/index.md`](../es/index.md) o consultar el [`README.md`](../../README.md).
