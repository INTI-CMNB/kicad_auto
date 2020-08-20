#!/bin/sh
rm *.deb
#curl -s https://api.github.com/repos/set-soft/mcpy/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i -
#curl -s https://api.github.com/repos/set-soft/macropy/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i -
curl -s https://api.github.com/repos/INTI-CMNB/kicad-automation-scripts/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i -
curl -s https://api.github.com/repos/INTI-CMNB/KiBoM/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i -
curl -s https://api.github.com/repos/INTI-CMNB/InteractiveHtmlBom/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i -
curl -s https://api.github.com/repos/INTI-CMNB/PcbDraw/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i -
curl -s https://api.github.com/repos/INTI-CMNB/KiBot/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i -

