# hash:sha256:3cc23a3d82cdaa5cc65e58af74f36190b17d59dec7f88bd58d297705fc9a7bd5
FROM registry.codeocean.com/codeocean/opencv:3.3.0-gcc5.4.0-ubuntu16.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gfortran=4:5.3.1-1ubuntu1 \
    && rm -rf /var/lib/apt/lists/*
