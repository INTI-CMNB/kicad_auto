FROM ghcr.io/inti-cmnb/kicad10_debian:latest
LABEL MAINTAINER="Salvador E. Tropea <set@ieee.org>"
LABEL Description="Layer used for new dependencies"
LABEL org.opencontainers.image.description="Layer used for new dependencies"

# Install reportlab
# Python support for ZStandard compression for KiCad 10 embedded files, should be moved to base_os
RUN     apt-get update && \
	apt-get -y install --no-install-recommends python3-reportlab python3-zstd && \
	rm -rf /var/lib/apt/lists/* /var/cache/debconf/templates.dat-old /var/lib/dpkg/status-old
