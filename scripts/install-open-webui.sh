#!/usr/bin/env bash
set -euo pipefail

CONTAINER="open-webui"
MODEL_API="http://127.0.0.1:11434"
WEBUI_URL="http://127.0.0.1:8080"

echo "=== Local AI: Open WebUI Setup ==="

for cmd in docker curl openssl; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Required command not found: $cmd"
        exit 1
    fi
done

echo "Starting Docker..."
sudo systemctl start docker

echo "Checking Ollama..."
if ! curl -fsS --max-time 5 "$MODEL_API/api/tags" >/dev/null; then
    echo "Ollama is not responding at $MODEL_API."
    echo "Start Ollama and run this script again."
    exit 1
fi

if sudo docker inspect "$CONTAINER" >/dev/null 2>&1; then
    echo "Open WebUI container already exists."
    sudo docker start "$CONTAINER" >/dev/null 2>&1 || true
else
    echo "Creating Open WebUI container..."
    WEBUI_SECRET_KEY="$(openssl rand -hex 32)"

    sudo docker run -d \
        --name "$CONTAINER" \
        --network=host \
        -v open-webui:/app/backend/data \
        -e OLLAMA_BASE_URL="$MODEL_API" \
        -e WEBUI_SECRET_KEY="$WEBUI_SECRET_KEY" \
        -e HOST=127.0.0.1 \
        --restart unless-stopped \
        ghcr.io/open-webui/open-webui:main
fi

echo "Waiting for Open WebUI..."
for i in $(seq 1 45); do
    if curl -fsS --max-time 2 "$WEBUI_URL/" >/dev/null 2>&1; then
        echo "Open WebUI is ready: $WEBUI_URL"
        exit 0
    fi
    sleep 2
done

echo "Open WebUI did not respond within 90 seconds."
echo "Check logs with: sudo docker logs open-webui"
exit 1