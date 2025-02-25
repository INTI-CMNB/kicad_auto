#!/bin/sh
set -e
# KiCad 6, tag the generic ki6 as latest and also for Docker Hub
docker pull ghcr.io/inti-cmnb/kicad_auto:ki6
docker tag ghcr.io/inti-cmnb/kicad_auto:ki6 setsoft/kicad_auto:ki6
docker tag ghcr.io/inti-cmnb/kicad_auto:ki6 ghcr.io/inti-cmnb/kicad6_auto:latest
docker push setsoft/kicad_auto:ki6
docker push ghcr.io/inti-cmnb/kicad6_auto:latest
# KiCad 7
docker pull ghcr.io/inti-cmnb/kicad_auto:ki7
docker tag ghcr.io/inti-cmnb/kicad_auto:ki7 setsoft/kicad_auto:ki7
docker tag ghcr.io/inti-cmnb/kicad_auto:ki7 ghcr.io/inti-cmnb/kicad7_auto:latest
docker push setsoft/kicad_auto:ki7
docker push ghcr.io/inti-cmnb/kicad7_auto:latest
# KiCad 8
docker pull ghcr.io/inti-cmnb/kicad_auto:ki8
docker tag ghcr.io/inti-cmnb/kicad_auto:ki8 setsoft/kicad_auto:ki8
docker tag ghcr.io/inti-cmnb/kicad_auto:ki8 ghcr.io/inti-cmnb/kicad8_auto:latest
docker push setsoft/kicad_auto:ki8
docker push ghcr.io/inti-cmnb/kicad8_auto:latest
# KiCad 9
docker pull ghcr.io/inti-cmnb/kicad_auto:ki9
docker tag ghcr.io/inti-cmnb/kicad_auto:ki9 setsoft/kicad_auto:ki9
docker tag ghcr.io/inti-cmnb/kicad_auto:ki9 ghcr.io/inti-cmnb/kicad9_auto:latest
docker push setsoft/kicad_auto:ki9
docker push ghcr.io/inti-cmnb/kicad9_auto:latest
# KiCad 5
docker pull ghcr.io/inti-cmnb/kicad_auto:ki5
docker tag ghcr.io/inti-cmnb/kicad_auto:ki5 setsoft/kicad_auto:latest
docker tag ghcr.io/inti-cmnb/kicad_auto:ki5 ghcr.io/inti-cmnb/kicad5_auto:latest
docker push setsoft/kicad_auto:latest
docker push ghcr.io/inti-cmnb/kicad5_auto:latest

