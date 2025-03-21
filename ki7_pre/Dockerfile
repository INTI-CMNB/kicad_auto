FROM ghcr.io/inti-cmnb/kicad7_debian:latest
MAINTAINER Salvador E. Tropea <set@ieee.org>
LABEL Description="Layer used for new dependencies"
LABEL org.opencontainers.image.description="Layer used for new dependencies"

RUN     apt-get update  && \
	echo "Use wget to download some stuff"  && \
	apt -y install --no-install-recommends wget && \
	wget http://http.us.debian.org/debian/pool/main/c/ca-certificates/ca-certificates_20241223_all.deb && \
	apt -y install --no-install-recommends ./*.deb && \
	apt-get -y remove wget && \
	apt-get -y autoremove && \
	rm /*.deb && \
	rm -rf /var/lib/apt/lists/* /var/cache/debconf/templates.dat-old /var/lib/dpkg/status-old

# Fix for the .deb downloader, should be removed in the next OS iteration
COPY dl_deb.py /usr/bin/
