# kicad_auto

Docker image for KiCad automation scripts suitable for CI/CD

The images are uploaded to [Docker Hub](https://hub.docker.com/repository/docker/setsoft/kicad_auto).

This image is based on [setsoft/kicad_debian](https://github.com/INTI-CMNB/kicad_debian) and adds some automation tools to it:

* [Kiplot](https://github.com/INTI-CMNB/kiplot) generate gerbers, drill and position files
* [kicad-automation-scripts](https://github.com/INTI-CMNB/kicad-automation-scripts) runs DRC/ERC, prints schematics and PCB
* [KiBoM](https://github.com/INTI-CMNB/KiBoM) generates HTML and CSV BoMs
* [InteractiveHtmlBom](https://github.com/INTI-CMNB/InteractiveHtmlBom) generates interactive HTML BoMs

The available tags are:

* **10.3-5.1.5** is KiCad 5.1.5 on Debian 10.3 with Kiplot 0.2.3, kicad-automation-scripts 1.1.6, KiBoM 1.6.2 and interactivehtmlbom 2.3

You can run it using a script like this:

```
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
export WORKDIR=RELATIVE_PATH_TO_KICAD_PROJECTS
export SUBDIR=SUBDIR_INSIDE_WORKDIR
docker run --rm -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY \
    -v $(pwd)/$WORKDIR:/home/$USER/workdir \
    --user $USER_ID:$GROUP_ID \
    --env NO_AT_BRIDGE=1 \
    --workdir="/home/$USER" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/home/$USER/.config/kicad:/home/$USER/.config/kicad:rw" \
    --volume="/home/$USER/.cache/kicad:/home/$USER/.cache/kicad:rw" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    setsoft/kicad_auto:10.3-5.1.5 /bin/bash -c "cd workdir/$SUBDIR; kiplot"
```

