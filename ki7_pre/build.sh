#!/bin/sh
docker build -f Dockerfile -t ghcr.io/inti-cmnb/kicad7_auto:latest_deps .
TG1=`docker run --rm ghcr.io/inti-cmnb/kicad7_auto:latest_deps kicad_version.py`
TG2=d`docker run --rm ghcr.io/inti-cmnb/kicad7_auto:latest_deps cat /etc/debian_version | tr -d '\n'`
docker tag ghcr.io/inti-cmnb/kicad7_auto:latest_deps ghcr.io/inti-cmnb/kicad7_auto:${TG1}_${TG2}_deps
docker push ghcr.io/inti-cmnb/kicad7_auto:${TG1}_${TG2}_deps
docker push ghcr.io/inti-cmnb/kicad7_auto:latest_deps

