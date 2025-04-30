#!/bin/bash

# Set browser environment variables
export DISPLAY=:1
export DBUS_SESSION_BUS_ADDRESS=/dev/null

# Clean up any existing X11 locks
rm -f /tmp/.X1-lock

# Kill any existing Xvfb processes
pkill Xvfb || true

# Start Xvfb
Xvfb :1 -screen 0 1024x768x24 -ac +extension GLX +render -noreset &

# Start fluxbox
fluxbox &

# Start VNC server
x11vnc -display :1 -forever -usepw -shared -rfbport 5900 -rfbportv6 -1 -loop -xkb -noxrecord -noxfixes -noxdamage -passwd darkbot &

# Wait for VNC server to start
sleep 5

# Run the jar file
cd /home/darkbot/darkbot
java -jar DarkBot.jar 