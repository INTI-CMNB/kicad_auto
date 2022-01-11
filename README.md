# kicad_auto

Docker image for KiCad automation scripts suitable for CI/CD

The main objetive is to use it as a base for [KiCad automation in CI/CD environments](https://github.com/INTI-CMNB/kicad_ci_test).

The images are uploaded to [Docker Hub](https://hub.docker.com/r/setsoft/kicad_auto).

This image is based on [setsoft/kicad_debian](https://github.com/INTI-CMNB/kicad_debian) and adds some automation tools to it:

* [Kiplot](https://github.com/INTI-CMNB/kiplot) generate gerbers, drill and position files
* [kicad-automation-scripts](https://github.com/INTI-CMNB/kicad-automation-scripts) runs DRC/ERC, prints schematics and PCB
* [KiBoM](https://github.com/INTI-CMNB/KiBoM) generates HTML and CSV BoMs
* [InteractiveHtmlBom](https://github.com/INTI-CMNB/InteractiveHtmlBom) generates interactive HTML BoMs
* [PcbDraw](https://github.com/INTI-CMNB/PcbDraw) generates 2D renders of the PCB

The available tags are:

* **10.3-5.1.5** is KiCad 5.1.5 on Debian 10.3 with Kiplot 0.2.4, kicad-automation-scripts 1.3.1, KiBoM 1.6.3 and interactivehtmlbom 2.3.1
* **10.4-5.1.6** is KiCad 5.1.6 on Debian 10.4 with KiBot 0.7.0, kicad-automation-scripts 1.4.2, KiBoM 1.8.0, interactivehtmlbom 2.3.3 and PcbDraw 0.6.0-2
* **10.4-5.1.9** (same as **latest**) is KiCad 5.1.9 on Debian 10.4 with KiBot 0.11.0, KiAuto 1.6.0, KiBoM 1.8.0, interactivehtmlbom 2.4.1 and PcbDraw 0.9.0-1
* **bullseye-6.0.0-RC1-20211204** (same as **nightly**) is KiCad 6.0.0 RC1 (20211204) on Debian bullseye with KiBot 0.11.0, kicad-automation-scripts 1.6.0, KiBoM 1.8.0, interactivehtmlbom 2.4.1 and PcbDraw 0.9.0-1
* **ki6.0.0_Ubuntu21.10** (same as **ki6**) KiCad 6.0.0 (final release) on is Ubuntu Impish with KiBot 0.11.0, kicad-automation-scripts 1.6.0, KiBoM 1.8.0, interactivehtmlbom 2.4.1 and PcbDraw 0.9.0-1

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

To create the docker image run the [build.sh](https://github.com/INTI-CMNB/kicad_auto/blob/master/build.sh) script.
This script will download the latest KiPlot and needed tools.

The [run.sh](https://github.com/INTI-CMNB/kicad_auto/blob/master/run.sh) script is an example of how to run KiPlot using this image locally.
You must edit the file to define the place where your KiCad project is located.
The **WORKDIR** variable indicates the directory where your project and libraries are located.
The **SUBDIR** variable is the subdir inside **WORKDIR** that contains the schematic and PCB files.


