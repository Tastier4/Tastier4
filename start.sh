#!/usr/bin/env bash
# Avvia un piccolo server HTTP locale e stampa l'indirizzo a cui collegarsi
# (utile per aprire l'app sull'iPad sulla stessa rete Wi-Fi).
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

PORT="${PORT:-8000}"

# IP della LAN (Linux: hostname -I; macOS: ipconfig)
if command -v hostname >/dev/null 2>&1 && hostname -I >/dev/null 2>&1; then
  IP="$(hostname -I | awk '{print $1}')"
elif command -v ipconfig >/dev/null 2>&1; then
  IP="$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null || echo 127.0.0.1)"
else
  IP="127.0.0.1"
fi

echo ""
echo "  App locale:     http://127.0.0.1:${PORT}/"
echo "  Su iPad/iPhone: http://${IP}:${PORT}/"
echo ""
echo "  Sull'iPad, apri quell'indirizzo in Safari, poi:"
echo "    Condividi → 'Aggiungi alla schermata Home' per averla come app."
echo ""
echo "  Ctrl-C per fermare il server."
echo ""

if command -v python3 >/dev/null 2>&1; then
  exec python3 -m http.server "$PORT" --bind 0.0.0.0
elif command -v python >/dev/null 2>&1; then
  exec python -m SimpleHTTPServer "$PORT"
else
  echo "Python non trovato. Apri direttamente $DIR/index.html nel browser."
  exit 1
fi
