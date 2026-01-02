FROM ghcr.io/inti-cmnb/kicad9_debian:latest
LABEL MAINTAINER="Salvador E. Tropea <set@ieee.org>"
LABEL Description="Layer used for new dependencies"
LABEL org.opencontainers.image.description="Layer used for new dependencies"

# Install reportlab
RUN     apt-get update && \
	apt-get -y install --no-install-recommends python3-reportlab && \
	rm -rf /var/lib/apt/lists/* /var/cache/debconf/templates.dat-old /var/lib/dpkg/status-old
