#!/usr/bin/env bash
# Apre l'app nel browser predefinito.
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
FILE="$DIR/index.html"

if command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$FILE"
elif command -v open >/dev/null 2>&1; then
  open "$FILE"
elif command -v start >/dev/null 2>&1; then
  start "" "$FILE"
else
  echo "Apri manualmente: $FILE"
fi
