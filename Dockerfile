FROM setsoft/kicad_debian:latest
MAINTAINER Salvador E. Tropea <set@ieee.org>
LABEL Description="KiCad with KiBot and other automation scripts"

COPY kicad-automation-scripts*.deb /
RUN     apt-get update  && \
	apt -y install --no-install-recommends ./kicad-automation-scripts*.deb && \
	apt-get -y autoremove && \
	rm /*.deb && \
	rm -rf /var/lib/apt/lists/*

COPY kibom*.deb /
RUN     apt-get update  && \
	apt -y install --no-install-recommends ./kibom*.deb && \
	apt-get -y autoremove && \
	rm /*.deb && \
	rm -rf /var/lib/apt/lists/*

COPY interactivehtmlbom*.deb /
RUN     apt-get update  && \
	apt -y install --no-install-recommends ./interactivehtmlbom*.deb && \
	apt-get -y autoremove && \
	rm /*.deb && \
	rm -rf /var/lib/apt/lists/*

COPY pcbdraw*.deb *pybars*.deb *pymeta*.deb  /
RUN     apt-get update  && \
	apt -y install --no-install-recommends ./pcbdraw*.deb ./*pybars*.deb ./*pymeta*.deb && \
	apt-get -y autoremove && \
	rm /*.deb && \
	rm -rf /var/lib/apt/lists/*

COPY kibot*.deb /
RUN     apt-get update  && \
	apt -y install ./kibot*.deb && \
	apt-get -y autoremove && \
	rm /*.deb && \
	rm -rf /var/lib/apt/lists/*

RUN     apt-get update  && \
	apt-get -y install --no-install-recommends make && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

