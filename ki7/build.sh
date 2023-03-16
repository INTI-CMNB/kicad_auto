#!/bin/sh
set -e
docker build -f Dockerfile -t ghcr.io/inti-cmnb/kicad7_auto:latest .
IT=2
TG1=`docker run --rm ghcr.io/inti-cmnb/kicad7_auto:latest kibot --version | sed 's/.* \([0-9]\+\.[0-9]\+\.[0-9]\+\) .*/\1/' | tr -d '\n'`
TG2=k`docker run --rm ghcr.io/inti-cmnb/kicad7_auto:latest kicad_version.py`
TG3=d`docker run --rm ghcr.io/inti-cmnb/kicad7_auto:latest cat /etc/debian_version | tr -d '\n'`
docker tag ghcr.io/inti-cmnb/kicad7_auto:latest ghcr.io/inti-cmnb/kicad7_auto:${TG1}-${IT}_${TG2}_${TG3}
docker tag ghcr.io/inti-cmnb/kicad7_auto:latest ghcr.io/inti-cmnb/kicad7_auto:${TG1}
docker tag ghcr.io/inti-cmnb/kicad7_auto:latest ghcr.io/inti-cmnb/kicad_auto:ki7
docker push ghcr.io/inti-cmnb/kicad7_auto:${TG1}-${IT}_${TG2}_${TG3}
docker push ghcr.io/inti-cmnb/kicad7_auto:${TG1}
docker push ghcr.io/inti-cmnb/kicad_auto:ki7
# Leave the following for the deploy:
#docker tag ghcr.io/inti-cmnb/kicad7_auto:latest setsoft/kicad_auto:ki7
#docker push ghcr.io/inti-cmnb/kicad7_auto:latest
#docker push setsoft/kicad_auto:ki7

