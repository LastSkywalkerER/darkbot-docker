#!/bin/bash

# Start Xvfb
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

# Make AppImage executable
chmod +x /root/darkbot/lib/backpage-linux-x86_64.AppImage
# lib/backpage-linux-x86_64.AppImage &

# Check browser
google-chrome --no-sandbox &
# google-chrome --headless --no-sandbox --disable-gpu --remote-debugging-port=9222 http://example.com

# Run the jar file
cd /root/darkbot
java -jar DarkBot.jar 