FROM ghcr.io/inti-cmnb/kicad9_debian:latest
MAINTAINER Salvador E. Tropea <set@ieee.org>
LABEL Description="Layer used for new dependencies"
LABEL org.opencontainers.image.description="Layer used for new dependencies"

# COPY kicad_3d_install.sh /usr/bin/

RUN     apt-get update  && \
	echo "Use wget to download some stuff"  && \
	apt -y install --no-install-recommends wget && \
	wget http://http.us.debian.org/debian/pool/main/c/ca-certificates/ca-certificates_20250419_all.deb && \
	apt -y install --no-install-recommends ./*.deb && \
	apt-get -y remove wget && \
	apt-get -y autoremove && \
	rm /*.deb && \
	rm -rf /var/lib/apt/lists/* /var/cache/debconf/templates.dat-old /var/lib/dpkg/status-old

# 9.0.1 changed the names of various constants related to units
RUN     printf "DXF_UNITS_MILLIMETERS = DXF_UNITS_MM\n" >> /usr/lib/python3/dist-packages/pcbnew.py && \
	printf "DXF_UNITS_INCHES = DXF_UNITS_INCH\n" >> /usr/lib/python3/dist-packages/pcbnew.py

# Install shapely. This is installed using pip, but also apt
# 2025-05-06: Now in base_os, can be removed in the next iteration
RUN     apt-get update && \
	apt-get -y install --no-install-recommends python3-shapely && \
	rm -rf /var/lib/apt/lists/* /var/cache/debconf/templates.dat-old /var/lib/dpkg/status-old
