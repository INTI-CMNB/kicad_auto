FROM setsoft/kicad_debian:latest
MAINTAINER Salvador E. Tropea <set@ieee.org>
LABEL Description="KiCad with KiBot and other automation scripts"

RUN     sed -i -e's/ main/ main contrib non-free/g' /etc/apt/sources.list  && \
	apt-get update  && \
	apt-get -y install -t buster-backports make wget curl rar bzip2 librsvg2-bin && \
	apt-get -y install --no-install-recommends imagemagick python3-qrcodegen git poppler-utils && \
	curl -s https://api.github.com/repos/INTI-CMNB/KiAuto/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/KiBoM/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/InteractiveHtmlBom/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/PcbDraw/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/hildogjr/KiCost/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/KiBot/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/set-soft/kicost-digikey-api-v3/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	apt -y install --no-install-recommends ./*.deb && \
	apt-get -y remove curl wget && \
	apt-get -y autoremove && \
	rm /*.deb && \
	rm -rf /var/lib/apt/lists/*
