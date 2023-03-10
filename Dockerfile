# UBUNTU OS IMAGE
FROM ubuntu:18.04

# RSTUDIO 
FROM rocker/rstudio:latest-daily

# INSTALL DEPENDENCIES
RUN apt-get update && apt-get install --no-install-recommends -y\
    libopenblas-dev \
    libprotobuf-dev \
    autoconf \
    automake \
    libtool \
    libxml2-dev \
    libhdf5-dev \
    zlib1g-dev \
    libpng-dev \
    tcl \
    tk \
    wget \
    unzip \
    cmake \
    make \
    g++ \
    pkg-config

# DOWNLOAD FFTW
RUN wget http://www.fftw.org/fftw-3.3.8.tar.gz && \
    tar -zxvf fftw-3.3.8.tar.gz && \
    rm -rf fftw-3.3.8.tar.gz && \
    cd fftw-3.3.8 && \
    ./configure && \
    make && \
    make install

# FIT-SNE - (path to fast_tsne -> FIt-SNE-master/fast_tsne.R)
RUN cd /. && \
    wget --no-check-certificate -O FIt-SNE.zip https://github.com/KlugerLab/FIt-SNE/archive/master.zip && \
    unzip FIt-SNE.zip && \
    rm -rf FIt-SNE.zip && \
    cd FIt-SNE-master && \
    g++ -std=c++11 -O3  src/sptree.cpp src/tsne.cpp src/nbodyfft.cpp  -o bin/fast_tsne -pthread -lfftw3 -lm -Wno-address-of-packed-member && \
    cd /.

# INSTALL DEPENDENCIES
RUN R -e "install.packages('remotes')" && \
    R -e "install.packages('latticeExtra')" && \
    R -e "install.packages('XML')" && \
    R -e "install.packages('BiocManager')" && \
    R -e "install.packages('cytolib')" && \
    R -e "BiocManager::install('flowCore')" && \
    R -e "BiocManager::install('CytoML')" && \
    R -e "BiocManager::install('flowWorkspace')" && \
    R -e "BiocManager::install('flowClust')" && \
    R -e "BiocManager::install('openCyto')" && \
    R -e "remotes::install_github('DillonHammill/openCyto')" && \
    R -e "remotes::install_github('DillonHammill/HeatmapR')"

# INSTALL CYTOEXPLORER
RUN R -e "options('timeout' = 999999)" && \
    R -e "remotes::install_github('DillonHammill/CytoExploreRData')" && \
    R -e "remotes::install_github('DillonHammill/CytoExploreR', ref = 'stable')"
    
# TIDYVERSE
RUN R -e "install.packages('tidyverse')"

# PYTHON
RUN R -e "options('timeout' = 999999)" && \
    R -e "install.packages('reticulate')" && \
    R -e "reticulate::install_miniconda()" && \
    R -e "reticulate::virtualenv_create('cytoexplorer')" && \
    R -e "reticulate::py_install('pacmap', envname = 'cytoexplorer', pip = TRUE)" && \
    R -e "reticulate::py_install('openTSNE', envname = 'cytoexplorer', pip = TRUE)"

