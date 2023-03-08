FROM ghcr.io/inti-cmnb/kicad_debian:nightly
MAINTAINER Salvador E. Tropea <set@ieee.org>
LABEL Description="KiCad with KiBot and other automation scripts"

RUN     sed -i -e's/ main/ main contrib non-free/g' /etc/apt/sources.list  && \
	apt-get update  && \
	apt-get -y install -t bullseye-backports curl && \
	apt-get -y install --no-install-recommends -t bullseye-backports git && \
	apt-get -y install make wget curl rar bzip2 librsvg2-bin ghostscript && \
	apt-get -y install --no-install-recommends imagemagick python3-qrcodegen poppler-utils && \
	dl_deb.py INTI-CMNB/KiAuto && \
	dl_deb.py INTI-CMNB/KiBoM && \
	dl_deb.py INTI-CMNB/InteractiveHtmlBom && \
	dl_deb.py INTI-CMNB/PcbDraw && \
	dl_deb.py hildogjr/KiCost && \
	dl_deb.py INTI-CMNB/KiBot && \
	dl_deb.py set-soft/kicost-digikey-api-v3 && \
	dl_deb.py INTI-CMNB/kicad-git-filters && \
	dl_deb.py INTI-CMNB/kidiff && \
	dl_deb.py set-soft/pcbnewTransition && \
	dl_deb.py INTI-CMNB/KiKit --skip kikit-doc && \
	apt -y install --no-install-recommends ./*.deb && \
	sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<!-- <policy domain="coder" rights="none" pattern="PDF" \/> -->/g' /etc/ImageMagick-6/policy.xml && \
	sed -i 's/<policy domain="coder" rights="none" pattern="PS" \/>/<!-- <policy domain="coder" rights="none" pattern="PS" \/> -->/g' /etc/ImageMagick-6/policy.xml && \
	apt-get -y remove curl wget && \
	apt-get -y autoremove && \
	rm /*.deb && \
	rm -rf /var/lib/apt/lists/*
# Needed for GitHub seen on git 2.39.1
RUN     echo "[safe]" >> /etc/gitconfig && \
	echo "	directory = *" >> /etc/gitconfig && \
	echo '[protocol "file"]' >> /etc/gitconfig && \
	echo '	allow = always' >> /etc/gitconfig
