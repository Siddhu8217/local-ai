# Local AI

A personal local AI assistant built with Ollama, NVIDIA Nemotron, and Open WebUI on Ubuntu.

Run an AI model locally and chat through a browser-based interface. A desktop shortcut helps start the required services and open the chat interface.

## Features

- Local AI inference through Ollama
- NVIDIA Nemotron 3 Nano 4B model
- Browser-based chat using Open WebUI
- One-click desktop launcher
- Docker-based Open WebUI deployment
- Persistent application data

## Technology Stack

- Ubuntu 24.04
- Ollama
- NVIDIA Nemotron 3 Nano 4B
- Docker Engine
- Open WebUI
- Bash

## Architecture

LocalAIWorkspace/
├── README.md
├── LICENSE
├── .gitignore
├── screenshots/
│   ├── local-ai-chat.png
│   └── local-ai-response.png
└── scripts/
    ├── install-local-ai.sh
    ├── install-open-webui.sh
    ├── install-desktop-shortcut.sh
    └── start-local-ai.sh

## Requirements

- Ubuntu Linux
- Ollama installed
- Docker Engine installed
- Internet connection for initial downloads and setup
- Sufficient RAM, storage, and compatible hardware

## Model Setup

Download the model:

```bash
ollama pull nemotron-3-nano:4b
```

List installed models:

```bash
ollama list
```

## Accessing Local AI

The web interface is available at:

http://127.0.0.1:8080

You can also launch it using the **Local AI** desktop shortcut configured on your computer.

## Project Structure

```text
LocalAIWorkspace/
├── README.md
├── .gitignore
└── scripts/
    └── start-local-ai.sh
```

## Privacy and Security

- Model inference is performed locally through Ollama.
- The web interface is configured for local access.
- Internet access may still be used for downloads and optional integrations.
- Never commit model weights, private conversations, credentials, or secret keys.
- Keep Docker, Ollama, and Open WebUI updated.

## Current Status

The Nemotron model, Ollama service, Open WebUI container, and desktop launcher have been tested on Ubuntu 24.04.

## License

This project is intended to use the MIT License. See `LICENSE` for details.