#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$HOME/LocalAIWorkspace"
LAUNCHER="$PROJECT_DIR/scripts/start-local-ai.sh"
DESKTOP_DIR="$HOME/Desktop"
SHORTCUT="$DESKTOP_DIR/Local AI.desktop"

echo "=== Local AI Desktop Shortcut Setup ==="

if [[ ! -f "$LAUNCHER" ]]; then
    echo "Launcher not found: $LAUNCHER"
    echo "Place this project in ~/LocalAIWorkspace first."
    exit 1
fi

chmod +x "$LAUNCHER"
mkdir -p "$DESKTOP_DIR"

cat > "$SHORTCUT" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Local AI
Comment=Open your local Nemotron AI assistant
Exec=$LAUNCHER
Icon=applications-internet
Terminal=false
Categories=Utility;Network;
StartupNotify=true
EOF

chmod +x "$SHORTCUT"

if command -v gio >/dev/null 2>&1; then
    gio set "$SHORTCUT" metadata::trusted true 2>/dev/null || true
fi

echo "Desktop shortcut created: $SHORTCUT"
echo "If Ubuntu asks, right-click it and select Allow Launching."