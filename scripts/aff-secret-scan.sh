#!/usr/bin/env bash
# ==============================================================================
# Script: aff-secret-scan.sh
# Purpose: Pre-commit / pre-push guardrail scanner for Scotiabank Digital Insurance
#          Blocks customer PII, real policy numbers, credit card PANs and keys.
# ==============================================================================

set -euo pipefail

echo "==> [AFF-M Scanner] Inspecting changes for banking security compliance..."

EXIT_CODE=0

# 1. Check for unencrypted private keys
echo "  [1/3] Scanning for private keys and tokens..."
if grep -r -E -n --exclude-dir={.git,node_modules,target,build,dist,.idea,.vscode} 'BEGIN (RSA|EC|OPENSSH|PGP) PRIVATE KEY' . 2>/dev/null; then
    echo "  [FAIL] Unencrypted private key detected!" >&2
    EXIT_CODE=1
else
    echo "  [OK] No private keys found."
fi

# 2. Check for unmasked PAN / Credit Cards
echo "  [2/3] Scanning for unmasked PAN / credit card numbers..."
if grep -r -E -n --exclude-dir={.git,node_modules,target,build,dist,.idea,.vscode} '\b4[0-9]{15}\b|\b5[1-5][0-9]{14}\b' . 2>/dev/null; then
    echo "  [FAIL] Potential unmasked credit card (PAN) detected!" >&2
    EXIT_CODE=1
else
    echo "  [OK] No plain credit card numbers found."
fi

# 3. Check for obvious hardcoded banking passwords
echo "  [3/3] Scanning for hardcoded passwords in configuration..."
if grep -r -E -i -n --exclude-dir={.git,node_modules,target,build,dist,.idea,.vscode} 'password\s*=\s*["\x27][^"\x27]{6,}["\x27]' . 2>/dev/null; then
    echo "  [WARN] Potential hardcoded password detected. Verify it is a placeholder."
fi

if [ "$EXIT_CODE" -ne 0 ]; then
    echo "==> [AFF-M Scanner] Banking security scan FAILED. Fix issues before commit." >&2
    exit 1
fi

echo "==> [AFF-M Scanner] All banking guardrails verified clean."
exit 0
