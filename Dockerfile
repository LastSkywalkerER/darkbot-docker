FROM ubuntu:22.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    xvfb \
    x11vnc \
    xterm \
    fluxbox \
    net-tools \
    chromium-browser \
    chromium-chromedriver \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libxshmfence1 \
    libxkbcommon0 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcb-dri3-0 \
    libxcb-render0 \
    libxcb-shape0 \
    libxcb-xfixes0 \
    libxcb-xinerama0 \
    libxcb-xinput0 \
    libxcb-xkb1 \
    libxcb-xtest0 \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/bash darkbot

# Set up VNC password (default: darkbot)
RUN mkdir -p /home/darkbot/.vnc && \
    chown -R darkbot:darkbot /home/darkbot/.vnc && \
    su - darkbot -c "x11vnc -storepasswd darkbot /home/darkbot/.vnc/passwd" && \
    chown darkbot:darkbot /home/darkbot/.vnc/passwd && \
    chmod 600 /home/darkbot/.vnc/passwd

# Create mount point for config
RUN mkdir -p /mnt/darkbot/config && \
    chown -R darkbot:darkbot /mnt/darkbot && \
    chmod 777 /mnt/darkbot/config

# Expose VNC port
EXPOSE 5900

# Copy and set permissions for start script
COPY scripts/start.sh /home/darkbot/scripts/
RUN chown darkbot:darkbot /home/darkbot/scripts/start.sh && chmod 755 /home/darkbot/scripts/start.sh

# Switch to non-root user
USER darkbot

CMD ["/home/darkbot/scripts/start.sh"] 