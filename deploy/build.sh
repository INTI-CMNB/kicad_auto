#!/bin/sh
set -e
# KiCad 6, tag the generic ki6 as latest and also for Docker Hub
docker tag ghcr.io/inti-cmnb/kicad_auto:ki6 setsoft/kicad_auto:ki6
docker tag ghcr.io/inti-cmnb/kicad_auto:ki6 ghcr.io/inti-cmnb/kicad6_auto:latest
docker push setsoft/kicad_auto:ki6
docker push ghcr.io/inti-cmnb/kicad6_auto:latest
# KiCad 7
docker tag ghcr.io/inti-cmnb/kicad_auto:ki7 setsoft/kicad_auto:ki7
docker tag ghcr.io/inti-cmnb/kicad_auto:ki7 ghcr.io/inti-cmnb/kicad7_auto:latest
docker push setsoft/kicad_auto:ki7
docker push ghcr.io/inti-cmnb/kicad7_auto:latest
# KiCad 5
docker tag ghcr.io/inti-cmnb/kicad_auto:latest setsoft/kicad_auto:latest
docker tag ghcr.io/inti-cmnb/kicad_auto:latest ghcr.io/inti-cmnb/kicad5_auto:latest
docker push setsoft/kicad_auto:latest
docker push ghcr.io/inti-cmnb/kicad5_auto:latest

