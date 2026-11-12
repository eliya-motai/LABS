#!/usr/bin/env bash
# Runs on EVERY start / resume of the codespace.
# There is no systemd inside the container, so services do not come back
# by themselves after the codespace is stopped and resumed.
set -uo pipefail

sudo service mysql start   >/dev/null 2>&1 || true
sudo service apache2 start >/dev/null 2>&1 || true

echo "Lab environment ready. Web server: port 80 (see the PORTS tab)."
