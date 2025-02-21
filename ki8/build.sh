#!/bin/sh
set -e
cp ../frame_plotter .
. ../iteration.sh
docker build -f Dockerfile --build-arg iteration=${IT} -t ghcr.io/inti-cmnb/kicad8_auto:latest .
TG1=`docker run --rm ghcr.io/inti-cmnb/kicad8_auto:latest kibot --version | sed 's/.* \([0-9]\+\.[0-9]\+\.[0-9]\+\(\.[0-9]\+\)\?\) .*/\1/' | tr -d '\n'`
TG2=k`docker run --rm ghcr.io/inti-cmnb/kicad8_auto:latest kicad_version.py`
TG3=d`docker run --rm ghcr.io/inti-cmnb/kicad8_auto:latest cat /etc/debian_version | tr -d '\n'`
docker tag ghcr.io/inti-cmnb/kicad8_auto:latest ghcr.io/inti-cmnb/kicad8_auto:${TG1}-${IT}_${TG2}_${TG3}
docker tag ghcr.io/inti-cmnb/kicad8_auto:latest ghcr.io/inti-cmnb/kicad8_auto:${TG1}
docker tag ghcr.io/inti-cmnb/kicad8_auto:latest ghcr.io/inti-cmnb/kicad_auto:ki8
docker push ghcr.io/inti-cmnb/kicad8_auto:${TG1}-${IT}_${TG2}_${TG3}
docker push ghcr.io/inti-cmnb/kicad8_auto:${TG1}
docker push ghcr.io/inti-cmnb/kicad_auto:ki8
# Leave the following for the deploy:
#docker tag ghcr.io/inti-cmnb/kicad8_auto:latest setsoft/kicad_auto:ki8
#docker push ghcr.io/inti-cmnb/kicad8_auto:latest
#docker push setsoft/kicad_auto:ki8

