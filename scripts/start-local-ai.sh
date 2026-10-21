#!/usr/bin/env bash
set -u

URL="http://127.0.0.1:8080"
MODEL="nemotron-3-nano:4b"

# Start Ollama if it is not running.
if ! systemctl is-active --quiet ollama; then
    pkexec /usr/bin/systemctl start ollama || {
        notify-send "Local AI" "Could not start Ollama."
        exit 1
    }
fi

# Wait for the local Ollama API.
ready=false
for i in $(seq 1 30); do
    if curl -fsS --max-time 2 \
        http://127.0.0.1:11434/api/tags >/dev/null 2>&1; then
        ready=true
        break
    fi
    sleep 1
done

if [ "$ready" != true ]; then
    notify-send "Local AI" "Ollama did not become ready."
    exit 1
fi

# Verify that Nemotron is installed.
if ! /usr/local/bin/ollama show "$MODEL" >/dev/null 2>&1; then
    notify-send "Local AI" "Nemotron was not found. Check your Ollama models."
    exit 1
fi

# Recover Docker and Open WebUI if the page is unavailable.
if ! curl -fsS --max-time 2 "$URL/" >/dev/null 2>&1; then
    pkexec /bin/sh -c '
        systemctl start docker || exit 1
        if [ "$(docker inspect -f "{{.State.Running}}" open-webui 2>/dev/null)" = true ]; then
            exit 0
        fi
        docker start open-webui
    ' || {
        notify-send "Local AI" "Could not start Open WebUI. Check Docker."
        exit 1
    }
fi

# Wait for the interface, then open it.
for i in $(seq 1 45); do
    if curl -fsS --max-time 2 "$URL/" >/dev/null 2>&1; then
        xdg-open "$URL"
        exit 0
    fi
    sleep 2
done

notify-send "Local AI" "Open WebUI did not respond within 90 seconds."
exit 1
