# DarkBot Docker Setup

This repository contains the Docker configuration for running DarkBot with a graphical interface using VNC.

## Project Structure

```
.
├── config/                 # Configuration files
│   └── config.json        # Main configuration file
├── scripts/               # Scripts directory
│   └── start.sh          # Startup script for the container
├── darkbot/              # DarkBot application directory (not tracked by git)
│   ├── DarkBot.jar       # DarkBot application
│   ├── lib/              # Application libraries
│   ├── plugins/          # Application plugins
│   ├── logs/             # Application logs
│   └── configs/          # Application configs
├── Dockerfile            # Docker image configuration
├── docker-compose.yml    # Docker Compose configuration
└── .gitignore           # Git ignore rules
```

## Prerequisites

- Docker installed on your system
- Docker Compose (optional, but recommended)
- VNC viewer (to access the graphical interface)

## Setup Instructions

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd darkbot
   ```

2. Create the `darkbot` directory and place your DarkBot files:
   ```bash
   mkdir darkbot
   # Copy DarkBot.jar and other necessary files into the darkbot directory
   ```

3. Configure the application:
   - Edit `config/config.json` to set your preferences
   - The default configuration uses Chromium as the browser

4. Build and run the container:
   ```bash
   # Using Docker Compose (recommended)
   docker-compose up -d

   # Or using Docker directly
   docker build -t darkbot .
   docker run -d --name darkbot -p 5900:5900 -v $(pwd)/darkbot:/home/darkbot/darkbot -v $(pwd)/config:/mnt/darkbot/config darkbot
   ```

## Accessing the Application

1. Connect to the VNC server:
   - Host: localhost
   - Port: 5900
   - Password: darkbot

2. Once connected, you'll see the Fluxbox window manager
   - The DarkBot application should start automatically
   - If it doesn't start, you can launch it manually from the terminal

## Configuration

The main configuration file is located at `config/config.json`. It contains:

```json
{
  "browser": {
    "type": "chromium",
    "path": "/usr/bin/chromium-browser"
  },
  "general": {
    "autoLogin": true,
    "autoStart": true
  }
}
```

You can modify this file to change:
- Browser type and path
- Auto-login settings
- Auto-start settings

## Troubleshooting

1. If the VNC connection fails:
   - Check if the container is running: `docker ps`
   - Check container logs: `docker logs darkbot`
   - Verify port 5900 is not in use

2. If DarkBot doesn't start:
   - Check if DarkBot.jar is present in the darkbot directory
   - Verify file permissions
   - Check container logs for errors

3. If the browser doesn't work:
   - Verify the browser path in config.json
   - Check container logs for browser-related errors

## Maintenance

- To stop the container:
  ```bash
  docker-compose down
  # or
  docker stop darkbot
  ```

- To update the configuration:
  1. Stop the container
  2. Modify config files
  3. Restart the container

- To update the application:
  1. Stop the container
  2. Replace DarkBot.jar and other files in the darkbot directory
  3. Restart the container

## Security Notes

- The VNC password is set to "darkbot" by default
- All data is stored in the mounted volumes
- The container runs as a non-root user for security 