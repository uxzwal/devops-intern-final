#!/usr/bin/env sh
set -euo pipefail

# Default target URL
TARGET=${1:-http://localhost:8080}

# Perform HTTP request and capture status code
status=$(curl -s -o /dev/null -w "%{http_code}" "$TARGET")

if [ "$status" -eq 200 ]; then
  echo "Health check passed (HTTP $status) for $TARGET"
  exit 0
else
  echo "Health check FAILED (HTTP $status) for $TARGET" >&2
  exit 1
fi
