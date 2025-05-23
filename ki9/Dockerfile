FROM ghcr.io/inti-cmnb/kicad9_auto:latest_deps
LABEL MAINTAINER="Salvador E. Tropea <set@ieee.org>"
LABEL Description="KiCad 9 w/KiBot and other automation scripts"
LABEL org.opencontainers.image.description="KiCad 9 w/KiBot and other automation scripts"

# Install all the tools, dependencies are already installed
RUN     apt-get update  && \
	dl_deb.py INTI-CMNB/KiBoM && \
	dl_deb.py INTI-CMNB/kicad-git-filters && \
	dl_deb.py set-soft/kicost-digikey-api-v3 && \
	dl_deb.py hildogjr/KiCost && \
	dl_deb.py INTI-CMNB/InteractiveHtmlBom && \
	dl_deb.py set-soft/pcbnewTransition && \
	dl_deb.py INTI-CMNB/KiKit --skip kikit-doc && \
	dl_deb.py INTI-CMNB/KiAuto && \
	dl_deb.py INTI-CMNB/kidiff && \
	dl_deb.py INTI-CMNB/KiBot && \
	dpkg -i kicad-git*.deb && \
	dpkg -i kibom*.deb && \
	dpkg -i interactivehtmlbom*.deb && \
	dpkg -i kicost-digi*.deb && \
	dpkg -i kicost_*.deb && \
	dpkg -i python3-pcbnewtransition*.deb && \
	dpkg -i python3-pymeta*.deb python3-pybars*.deb kikit*.deb && \
	dpkg -i kiauto_*.deb && \
	dpkg -i kidiff_*.deb && \
	dpkg -i kibot_*.deb && \
	rm /*.deb && \
	rm -rf /var/lib/apt/lists/* /var/cache/debconf/templates.dat-old /var/lib/dpkg/status-old

ARG iteration
ENV KIBOT_ITERATION=$iteration

RUN     kibot --version | sed 's/.* \([0-9]\+\.[0-9]\+\.[0-9]\+\) .*/\1/' | tr -d '\n' > /etc/kiauto_tag && \
	echo -n -${KIBOT_ITERATION}_k >> /etc/kiauto_tag && \
	kicad_version.py >> /etc/kiauto_tag && \
	echo -n _d >> /etc/kiauto_tag && \
	cat /etc/debian_version | tr -d '\n' >> /etc/kiauto_tag
