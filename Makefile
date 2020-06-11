#!/usr/bin/make
tagname = 10.4-5.1.6
docker_user = setsoft
docker_img = setsoft/kicad_auto

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

# If docker is not installer int the host system
install_docker:
	sudo apt install docker.io
	sudo systemctl enable --now docker
	sudo usermod -aG docker $(USER)

clean:
	@ rm -rf *.deb

.PHONY: download_packages build_release upload_image install_docker clean

