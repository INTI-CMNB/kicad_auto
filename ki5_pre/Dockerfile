FROM ghcr.io/inti-cmnb/kicad5_debian:latest
MAINTAINER Salvador E. Tropea <set@ieee.org>
LABEL Description="Layer used for new dependencies"
LABEL org.opencontainers.image.description "Layer used for new dependencies"

RUN     apt-get update  && \
	echo "Use wget to download some stuff"  && \
	apt -y install --no-install-recommends wget && \
	echo "XLSX Writer 3 fixes some important limitations in URLs (used by KiBoM, KiCost, KiBot, etc.)"  && \
	wget http://http.us.debian.org/debian/pool/main/x/xlsxwriter/python3-xlsxwriter_3.0.2-2_all.deb  && \
	apt -y install --no-install-recommends ./*.deb && \
	apt-get -y remove wget && \
	apt-get -y autoremove && \
	rm /*.deb && \
	rm -rf /var/lib/apt/lists/* /var/cache/debconf/templates.dat-old /var/lib/dpkg/status-old
