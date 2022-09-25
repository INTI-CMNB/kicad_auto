FROM manjarolinux/base
MAINTAINER Salvador E. Tropea <set@ieee.org>
LABEL Description="KiCad with KiBot and other automation scripts"

RUN     pacman -Syyu --noconfirm && \
	pacman -S yay binutils python-pip --noconfirm && \
	su builder -c "yay -S --noconfirm rar" && \
	pacman -S kicad kicad-library ghostscript gsfonts imagemagick librsvg pandoc texlive-core --noconfirm && \
	pacman -S recordmydesktop xdotool xclip libxslt python-psutil python-xvfbwrapper --noconfirm && \
	pip install KiAuto && \
	pacman -S python-xlsxwriter --noconfirm && \
	git clone https://github.com/INTI-CMNB/KiBoM.git && \
	cd KiBoM/ && \
	pip install . && \
	cd .. && \
	rm -r KiBoM/ && \
	git clone https://github.com/INTI-CMNB/InteractiveHtmlBom.git && \
	cd InteractiveHtmlBom/ && \
	pip install . && \
	cd .. && \
	rm -r InteractiveHtmlBom/ && \
	pip install KiDiff && \
	pacman -S python-numpy python-lxml python-mistune1 python-pybars3 python-wand python-yaml python-pcbnewtransition python-scipy --noconfirm && \
	su builder -c "yay -S python-svgpathtools-git --noconfirm" && \
	git clone https://github.com/INTI-CMNB/PcbDraw.git && \
	cd PcbDraw/ && \
	git submodule update --init --recursive && \
	git checkout v0.9.0_maintain && \
	pip install . && \
	cd .. && \
	rm -r PcbDraw/ && \
	pacman -S python-inflection python-pyopenssl python-tldextract python-dateutil --noconfirm && \
	pip install kicost_digikey_api_v3 dependencies && \
	pacman -S python-beautifulsoup4 python-tqdm python-validators python-colorama python-pillow --noconfirm && \
	pip install kicost && \
	pip install kibot
