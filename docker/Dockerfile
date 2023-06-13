FROM arm64v8/ubuntu:20.04

# Set the working directory
WORKDIR /workspace

# Update the package lists for upgrades and new packages
RUN apt-get update

# Install wget
RUN apt-get install -y wget

# Define CMake version
ARG CMAKE_VERSION=3.22.1

# Download and run the installation script
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-aarch64.sh \
    && chmod +x cmake-${CMAKE_VERSION}-linux-aarch64.sh \
    &&  ./cmake-${CMAKE_VERSION}-linux-aarch64.sh --skip-license --prefix=/usr/local \
    && rm cmake-${CMAKE_VERSION}-linux-aarch64.sh


# Install basic software and ca-certificates
RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates \
  gcc \
  g++ \
  make \
  wget \
  python \
  unzip \
  patchelf \
  python-dev \
  git 


# Clone the Paddle Lite repo and checkout the develop branch
RUN git clone https://github.com/PaddlePaddle/Paddle-Lite.git && cd Paddle-Lite && git checkout develop

WORKDIR /workspace/Paddle-Lite/lite

# Change parameters in the build script
RUN sed -i 's/ARCH=armv8/ARCH=armv8\nWITH_EXCEPTION=ON\nWITH_EXTRA=ON/' ./tools/build_linux.sh

# Execute the build script
RUN ./tools/build_linux.sh

RUN cp -r /workspace/Paddle-Lite/build.lite.linux.armv8.gcc/inference_lite_lib.armlinux.armv8/ /artifacts/

