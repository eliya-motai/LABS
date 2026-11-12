#!/usr/bin/env bash
# Runs ONCE, when the codespace is first created.
# Everything here is intentionally thin: setup.sh in the repo root stays
# the single source of truth for lab provisioning.
set -euo pipefail

echo "=== [on-create] starting services ==="
sudo service mysql start || echo "!! mysql failed to start"
sudo service apache2 start || echo "!! apache2 failed to start"

# Give MySQL a moment to open its socket before setup.sh talks to it.
for _ in $(seq 1 30); do
  if sudo mysqladmin ping --silent >/dev/null 2>&1; then break; fi
  sleep 1
done

if [ -f "setup.sh" ]; then
  echo "=== [on-create] running repo setup.sh ==="
  chmod +x setup.sh || true
  # Run it exactly as it runs on a normal Ubuntu host.
  bash setup.sh < /dev/null || true
else
  echo "=== [on-create] no setup.sh in repo root - skipping ==="
fi

echo "=== [on-create] done ==="
