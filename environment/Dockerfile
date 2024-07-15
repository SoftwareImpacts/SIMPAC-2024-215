# hash:sha256:29004c8cc3a33fca8a36d764b07243e67cb0e565026636fa140a6ca209eff89f
FROM registry.codeocean.com/codeocean/opencv:3.3.0-gcc5.4.0-ubuntu16.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gfortran \
    && rm -rf /var/lib/apt/lists/*
