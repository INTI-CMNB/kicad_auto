#!/usr/bin/make
tagname = 10.4-5.1.6
docker_user = setsoft
docker_img = setsoft/kicad_auto

CWD := $(abspath $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST))))))
USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)

download_packages:
	./download.sh

build: download_packages
	docker build -f Dockerfile -t $(docker_img):$(tagname) .
	docker build -f Dockerfile -t $(docker_img):latest .

upload_image:
	#docker login --username=$(docker_user)
	docker push $(docker_img):$(tagname)
	docker push $(docker_img):latest

release: build upload_image

# If docker is not installed in the host system
install_docker:
	sudo apt install docker.io
	sudo systemctl enable --now docker
	sudo usermod -aG docker $(USER)

clean:
	@ rm -rf *.deb

# Docker shell for the current user.
# You can access the desktop and your home.
# Changes to the docker image are discarded, but changes to your home are real changes.
docker_shell:
	docker run  -it --rm -v $(CWD):$(CWD) --workdir="$(CWD)" \
	-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$(DISPLAY) \
	--user $(USER_ID):$(GROUP_ID) \
	--volume="/etc/group:/etc/group:ro" \
	--volume="/etc/passwd:/etc/passwd:ro" \
	--volume="/etc/shadow:/etc/shadow:ro" \
	--volume="/home/$(USER):/home/$(USER):rw" \
	$(docker_img):$(tagname) /bin/bash

.PHONY: download_packages build_release upload_image install_docker clean

