CytoExploreR-Docker
================
Dillon Hammill
2023-03-10

Docker development environment for CytoExploreR Version 2.0.0

This repository contains a dockerfile and associated build instructions
to launch a CytoExploreR v2.0.0 RStudio environment for testing,
development or benchmarking.

The pre-built docker images are available for download (amd64 platform)
from docker hub: `docker pull dhammill/cytoexplorer-devel:v2.0.0`.

This docker image contains:

1.  Ubuntu 18.04
2.  FFTW
3.  FIt-SNE executable
4.  Open-source cytoverse packages
5.  CytoExploreRData datasets
6.  CytoExploreR
7.  tidyverse packages

# Build Docker image locally

1.  Clone this repository to obtain a local copy:
    `git clone https://github.com/djhammill/CytoExploreR-Docker.git`

2.  From the terminal/command prompt build and tag the docker image:
    `docker build -t cytoexplorer-devel:v2.0.0 .`

3.  Check image has been built successfully: `docker image ls`

# Start Docker container & mount local drives

1.  Either pull down pre-built image from Docker Hub
    (`docker pull dhammill/cytoexplorer-devel:v2.0.0`) or build image
    locally as above.

2.  Run the CytoExploreR version 2.0.0 docker image inside a container
    and mount directory (edit /path/to/mount). Remove `dhammill` below
    if image was built locally.

``` r
docker run --rm -dit --mount type=bind,source=/path/to/mount,destination=/home/rstudio/project -p 8787:8787 -e PASSWORD=cytoexplorer dhammill/cytoexplorer-devel:v2.0.0
```

3.  Open `localhost:8787` in a web browser.

4.  Log into the RStudio session using `username = rstudio` and
    `password = cytoexplorer`.
