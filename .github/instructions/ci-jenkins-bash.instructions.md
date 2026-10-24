---
applyTo: "**/Jenkinsfile*,**/*.sh"
---

# CI/CD Jenkins & Bash Scripting Instructions

## Corporate Jenkinsfile Guardrails
1. **Pipeline Stages:**
   - Verify that all stages exist and pass locally when relevant: Checkout, Compile, Unit Tests, Code Coverage (Jacoco / Karma / XCTest), SonarQube Quality Gate.
2. **Secrets:**
   - Never pass plaintext tokens or credentials into Jenkins commands; reference Jenkins Credentials ID (`withCredentials`).

## Bash Scripting Standards
1. **Safety Flags:**
   - Always include `set -euo pipefail` at the start of any bash script.
2. **Idempotence & Cleanup:**
   - Implement `trap cleanup EXIT` for temporary files.
   - Support `--dry-run` where scripts perform file or environment alterations.
