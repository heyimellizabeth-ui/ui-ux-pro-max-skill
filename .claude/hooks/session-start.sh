#!/bin/bash
# SessionStart hook for Claude Code on the web.
# Installs the cli/ Node dependencies and verifies Python (the search scripts
# have no external deps). Synchronous, idempotent, non-interactive.
set -euo pipefail

# Only run in remote (Claude Code on the web) sessions.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR"

if [ -f cli/package.json ]; then
  echo "[session-start] Installing cli/ Node dependencies (npm install)..."
  (cd cli && npm install)
fi

# Search/design scripts run on plain Python 3 with no external dependencies.
echo "[session-start] Python: $(python3 --version)"

echo "[session-start] Done."
