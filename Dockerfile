FROM setsoft/kicad_debian:latest
MAINTAINER Salvador E. Tropea <set@ieee.org>
LABEL Description="KiCad with KiBot and other automation scripts"

RUN     apt-get update  && \
	apt-get -y install make wget curl && \
	curl -s https://api.github.com/repos/INTI-CMNB/KiAuto/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/KiBoM/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/InteractiveHtmlBom/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/PcbDraw/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/KiBot/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	apt -y install --no-install-recommends ./*.deb && \
	apt-get -y remove curl wget && \
	apt-get -y autoremove && \
	rm /*.deb && \
	rm -rf /var/lib/apt/lists/*
