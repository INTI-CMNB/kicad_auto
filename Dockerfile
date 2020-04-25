FROM setsoft/kicad_debian:latest
MAINTAINER Salvador E. Tropea <set@ieee.org>
LABEL Description="KiCad with KiPlot and other automation scripts"

COPY *.deb /
RUN     apt-get update  && \
	apt-get -y install --no-install-recommends make && \
	apt -y install --no-install-recommends ./*.deb && \
	apt-get -y autoremove && \
	rm /*.deb && \
	rm -rf /var/lib/apt/lists/*

