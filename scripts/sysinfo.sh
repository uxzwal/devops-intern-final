#!/usr/bin/env sh
set -euo pipefail

# Current user and effective UID
echo "User: $(whoami)"
echo "Effective UID: $(id -u)"

# Hostname and kernel release
echo "Hostname: $(hostname)"
echo "Kernel: $(uname -r)"

# System date in ISO-8601 format
echo "Date (ISO-8601): $(date -Iseconds)"

# Disk usage in human-readable form
echo "Disk Usage:" && df -h .

# Memory usage
echo "Memory Usage:" && free -h

# Docker daemon status
if docker info >/dev/null 2>&1; then
  echo "Docker daemon: running"
else
  echo "Docker daemon: not running"
fi
