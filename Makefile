#!/usr/bin/make
tagname = 10.4-5.1.6
tagname_rc = 10.4-5.1.6rc
tagname_ng = bullseye-5.99-20201002
docker_user = setsoft
docker_img = setsoft/kicad_auto

CWD := $(abspath $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST))))))
USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)

build:
	docker build --no-cache -f Dockerfile -t $(docker_img):$(tagname) .
	docker build -f Dockerfile -t $(docker_img):latest .

build_rc:
	docker build -f Dockerfile -t $(docker_img):$(tagname_rc) .

build_ng:
	docker build -f Dockerfile-nightly -t $(docker_img):$(tagname_ng) .
	docker build -f Dockerfile-nightly -t $(docker_img):nightly .

upload_image:
	#docker login --username=$(docker_user)
	docker push $(docker_img):$(tagname)
	docker push $(docker_img):latest

upload_image_rc:
	docker push $(docker_img):$(tagname_rc)

upload_image_ng:
	docker push $(docker_img):$(tagname_ng)
	docker push $(docker_img):nightly

release: build upload_image

release_rc: build_rc upload_image_rc

release_ng: build_ng upload_image_ng

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

.PHONY: download_packages build_release upload_image upload_image_rc install_docker clean build build_rc release release_rc

