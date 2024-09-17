#!/bin/sh
apt-get -y update
apt-get install -y -t bookworm-backports --no-install-recommends kicad-packages3d
rm -rf /var/lib/apt/lists/*
