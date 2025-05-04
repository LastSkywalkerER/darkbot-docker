FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    wget \
    xvfb \
    x11vnc \
    fluxbox \
    curl \
    ca-certificates \
    gnupg2 \
    libvulkan1 \
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
    fuse \
    libfuse2 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libxss1 \
    libxtst6 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Set timezone
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime

# Install Google Chrome Stable 
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb

# Set up VNC password (default: darkbot)
RUN mkdir -p /root/.vnc && \
    x11vnc -storepasswd darkbot /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

# Create mount point for config
RUN mkdir -p /mnt/darkbot/config && \
    chmod 777 /mnt/darkbot/config

# Copy darkbot files
COPY darkbot /root/darkbot

# Expose VNC port
EXPOSE 5900

# Copy and set permissions for start script
COPY scripts/start.sh /root/scripts/
RUN chmod 755 /root/scripts/start.sh

CMD ["/root/scripts/start.sh"] 