#!/bin/sh
./download.sh
docker build -f Dockerfile -t setsoft/kicad_auto:10.4-5.1.6 .
