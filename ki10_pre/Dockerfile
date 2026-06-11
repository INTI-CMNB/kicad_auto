FROM ghcr.io/inti-cmnb/kicad10_debian:latest
LABEL MAINTAINER="Salvador E. Tropea <set@ieee.org>"
LABEL Description="Layer used for new dependencies"
LABEL org.opencontainers.image.description="Layer used for new dependencies"

# kicad-cli pcb render patcher
COPY patch_cli.py /usr/bin/
# Install reportlab
# Python support for ZStandard compression for KiCad 10 embedded files, should be moved to base_os
RUN     apt-get update && \
	apt-get -y install --no-install-recommends python3-reportlab python3-zstd python3-setuptools && \
	echo Patching kicad-cli && \
	apt-get -y install --no-install-recommends python3-capstone python3-pip && \
	pip install --break-system-packages lief && \
	python3 /usr/bin/patch_cli.py /usr/bin/kicad-cli && \
	pip uninstall --break-system-packages lief -y && \
	apt-get -y remove python3-capstone python3-pip && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/* /var/cache/debconf/templates.dat-old /var/lib/dpkg/status-old
