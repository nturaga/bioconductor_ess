#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

apt-get update

## install ess
apt-get install -y --no-install-recommends \
	file \
	git \
	curl \
	libgc1c2 \
	libclang-dev \
	libcurl4-openssl-dev \
	ack-grep \
	emacs \
	ess

## install texlive

wget -O - https://raw.githubusercontent.com/rocker-org/rocker-versioned2/master/scripts/install_texlive.sh | bash

## install bioc system dependencies

wget -O - https://raw.githubusercontent.com/Bioconductor/bioconductor_docker/master/bioc_scripts/install_bioc_sysdeps.sh | bash

## install BiocManager and devtools packages
curl -O https://raw.githubusercontent.com/Bioconductor/bioconductor_docker/master/bioc_scripts/install.R \
    && R -f install.R

curl -O http://bioconductor.org/checkResults/devel/bioc-LATEST/Renviron.bioc \
    && cat Renviron.bioc | grep -o '^[^#]*' | sed 's/export //g' >>/etc/environment \
    && cat Renviron.bioc >> /usr/local/lib/R/etc/Renviron.site \
    && rm -rf Renviron.bioc
