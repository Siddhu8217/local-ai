#!/usr/bin/env bash
set -euo pipefail

MODEL="nemotron-3-nano:4b"

echo "=== Local AI Setup ==="

if [[ "$(uname -s)" != "Linux" ]]; then
    echo "This installer is intended for Linux."
    exit 1
fi

if ! command -v ollama >/dev/null 2>&1; then
    echo "Ollama is not installed."
    echo "Install it using the official instructions:"
    echo "https://ollama.com/download"
    exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is not installed."
    echo "Install Docker Engine using the official instructions:"
    echo "https://docs.docker.com/engine/install/ubuntu/"
    exit 1
fi

echo "Checking Ollama service..."
if ! systemctl is-active --quiet ollama; then
    echo "Starting Ollama..."
    sudo systemctl start ollama
fi

echo "Downloading the model if necessary..."
ollama pull "$MODEL"

echo
echo "Dependency and model setup completed."
echo "Open WebUI must be configured separately if it is not already installed."
echo "See README.md for the next steps."