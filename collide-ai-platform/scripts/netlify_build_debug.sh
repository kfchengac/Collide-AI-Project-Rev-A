#!/usr/bin/env bash
set -euo pipefail

echo "=== Netlify debug build script ==="
echo "PWD: $(pwd)"
echo "USER: $(whoami || true)"
echo "Python: $(python3 --version || true)"
echo "Node: $(node --version || true)"
echo "--- Environment variables (filtered) ---"
env | grep -E 'NETLIFY|GITHUB|CI' || true

echo "\n--- Running static sync ---"
python3 scripts/sync_static.py || true

echo "\n--- Root listing ---"
ls -la

echo "\n--- netlify/functions listing ---"
if [ -d netlify/functions ]; then
  ls -la netlify/functions || true
  echo "\n--- Show a short head of python functions ---"
  for f in netlify/functions/*.py; do
    echo "---- $f ----"
    head -n 60 "$f" || true
  done
else
  echo "netlify/functions directory not found"
fi

echo "\n--- public listing ---"
ls -la public || true

echo "\n--- Finished debug build script ---"
exit 0
