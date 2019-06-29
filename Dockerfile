FROM debian:bookworm
LABEL description="Microsoft Edge Browser With noVNC" \
	maintainer="admin@fever.ink" \
	version="2.0"

# Install Chrome
RUN \
	apt update && \
	apt upgrade -y && \
	apt install --no-install-recommends -y wget && \
	apt install --no-install-recommends -y fonts-droid-fallback && \
	wget --no-check-certificate https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_138.0.3351.65-1_amd64.deb?brand=M102 -O /tmp/microsoft-edge-stable.deb && \
	apt install --no-install-recommends -f -y /tmp/microsoft-edge-stable.deb && \
	rm /tmp/microsoft-edge-stable.deb

# Install vnc server and noVNC
RUN \
	apt install --no-install-recommends -y tightvncserver xfonts-base git websockify python3 net-tools procps && \
	git clone https://github.com/novnc/noVNC.git /opt/novnc

# Configuration
COPY msedge-novnc.sh /usr/bin/msedge-novnc.sh
RUN \
	ln -s /opt/novnc/vnc.html /opt/novnc/index.html && \
	chmod +x /usr/bin/msedge-novnc.sh

ENV \
	WIDTH=1280 \
	HEIGHT=720 \
	LANGUAGE=zh_CN.UTF-8
	
EXPOSE 6080

VOLUME /config

 # Clean
RUN \
	apt purge -y git && \
	apt autoremove --purge -y && \
	rm -rf /var/lib/apt/lists/*

CMD ["bash", "-c", "/usr/bin/msedge-novnc.sh"]
