FROM ghcr.io/inti-cmnb/kicad8_auto:latest_deps
MAINTAINER Salvador E. Tropea <set@ieee.org>
LABEL Description="KiCad 8 w/KiBot and other automation scripts"
LABEL org.opencontainers.image.description "KiCad 8 w/KiBot and other automation scripts"

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
	apt -y install --no-install-recommends ./*.deb && \
	apt-get -y autoremove && \
	rm /*.deb && \
	rm -rf /var/lib/apt/lists/* /var/cache/debconf/templates.dat-old /var/lib/dpkg/status-old

# Temporal fix for 1.8.2
COPY frame_plotter /usr/share/kibot/tools/

ARG iteration
ENV KIBOT_ITERATION=$iteration

RUN     kibot --version | sed 's/.* \([0-9]\+\.[0-9]\+\.[0-9]\+\) .*/\1/' | tr -d '\n' > /etc/kiauto_tag && \
	echo -n -${KIBOT_ITERATION}_k >> /etc/kiauto_tag && \
	kicad_version.py >> /etc/kiauto_tag && \
	echo -n _d >> /etc/kiauto_tag && \
	cat /etc/debian_version | tr -d '\n' >> /etc/kiauto_tag
