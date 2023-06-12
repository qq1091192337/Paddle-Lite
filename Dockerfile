# Start from a base image with Python and other required tools installed
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install basic software
RUN apt update && apt-get install -y --no-install-recommends \
  gcc g++ make wget python unzip patchelf python-dev git cmake

# Install CMake 3.10.3 (requires at least CMake 3.10)
RUN apt-get install -y --no-install-recommends cmake

# Clone the Paddle Lite repo and checkout the develop branch
RUN git clone https://github.com/PaddlePaddle/Paddle-Lite.git && cd Paddle-Lite && git checkout develop

WORKDIR /Paddle-Lite

# Modify the build script parameters
RUN sed -i 's/WITH_EXCEPTION=OFF/WITH_EXCEPTION=ON/' ./lite/tools/build_linux.sh
RUN sed -i 's/WITH_EXTRA=OFF/WITH_EXTRA=ON/' ./lite/tools/build_linux.sh

# Build Paddle Lite
RUN ./lite/tools/build_linux.sh
