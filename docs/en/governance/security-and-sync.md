# Governance, Enterprise Security & OneDrive Synchronization

This document covers enterprise information security guardrails, cross-platform OS detection, and the optional Microsoft OneDrive documentation backup mechanism in **AFF-Copilot**.

---

## 1. Information Security Policies

In banking, healthcare, and regulated enterprise environments, adopting AI engineering assistants requires strict data privacy controls. AFF-Copilot enforces *Security by Design*.

### A. Zero PII Policy (Personally Identifiable Information)
- **Strict Prohibition:** Storing real customer identifiers (national IDs, credit card numbers, bank account numbers, physical addresses, phone numbers, or personal emails) is strictly banned from logs, specifications (`spec.md`), contracts (`contract.md`), and agent context.
- **Synthetic Test Data:** All API examples, fixtures, unit tests, and mocks must utilize synthetic, non-correlatable identifiers.

### B. Zero Plaintext Secrets Policy
- Hardcoded API keys, passwords, private certificates, and raw tokens are strictly prohibited across both the framework hub and connected repositories.
- Sensitive environment variables must be managed via enterprise vaults (HashiCorp Vault, AWS Secrets Manager, Azure Key Vault).

### C. Automated Pre-Commit Audit (`aff-secret-scan.sh`)
The framework includes a local secret scanner:
```bash
./scripts/aff-secret-scan.sh
```
The script scans changed files for high-entropy tokens, private keys, cloud credentials (AWS, Azure, GCP, GitHub), and credit card number patterns using the Luhn algorithm.

---

## 2. Cross-Platform OS Detection

All automation scripts in [`scripts/`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/scripts/) feature built-in **operating system detection**:

```bash
OS_TYPE="$(uname -s)"
case "${OS_TYPE}" in
    Linux*)     PLATFORM="linux" ;;
    Darwin*)    PLATFORM="macos" ;;
    CYGWIN*|MINGW*|MSYS*) PLATFORM="windows" ;;
    *)          PLATFORM="unknown" ;;
esac
```

This guarantees seamless execution across:
- **Linux:** Ubuntu, Debian, Fedora, Arch, RHEL.
- **macOS:** Intel and Apple Silicon (M1/M2/M3/M4) using zsh or bash.
- **Windows:** Execution via **Git Bash** or POSIX-compatible shells (MSYS2/Cygwin).

---

## 3. Optional Microsoft OneDrive Synchronization

### Why OneDrive?
Many organizations require agile cells to maintain an automated backup of team knowledge bases (`knowledge/`), feature specifications (`work/`), and cell configurations (`cell.config.yaml`) in corporate Microsoft 365 cloud storage, **without polluting production code repositories with AI metadata**.

AFF-Copilot provides a decoupled, unidirectional background synchronization mechanism.

### How to Enable Synchronization:
When initializing the framework, supply your corporate OneDrive directory path:

```bash
./scripts/setup-framework.sh --enable-onedrive "~/OneDrive - MyCompany/Cell-Docs"
```

The script configures:
1. The target path in `scripts/.sync-config`.
2. A non-blocking Git hook at `.git/hooks/post-commit` inside the AFF hub repository.

### Background Hook Mechanics:
- **Trigger:** Every commit inside the AFF-Copilot hub triggers [`sync-onedrive.sh`](file:///home/gabrielcruzsoto/Proyectos/Tools_Agents/projects/aigile-forge-framework-copilot/scripts/sync-onedrive.sh) **asynchronously in the background** (`nohup ... &`).
- **Zero Blocking:** Local git operations remain fast and never freeze waiting on cloud sync.
- **Strict Exclusion Rules:**
  - **Included in Sync:** `knowledge/`, `work/`, `sprints/`, `templates/`, `cell.config.yaml`, `AGENTS.md`, `README.md`, and `docs/`.
  - **Excluded from Sync:** `.git/`, source code repositories, `node_modules/`, compiled binaries, `.env` files, and temporary artifacts.

### Manual Management Commands:
```bash
# Check sync status and configured target folder
./scripts/sync-onedrive.sh --status

# Trigger an immediate manual synchronization
./scripts/sync-onedrive.sh

# Disable automated synchronization
./scripts/sync-onedrive.sh --disable
```
