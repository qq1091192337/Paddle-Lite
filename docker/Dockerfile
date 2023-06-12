FROM arm64v8/ubuntu:20.04

# Set the working directory
WORKDIR /workspace
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | sudo apt-key add - && \
  apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main' && \
  

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
  git \
  cmake


# Clone the Paddle Lite repo and checkout the develop branch
RUN git clone https://github.com/PaddlePaddle/Paddle-Lite.git && cd Paddle-Lite && git checkout develop

WORKDIR /workspace/Paddle-Lite/lite

# Change parameters in the build script
RUN sed -i 's/ARCH=armv8/ARCH=armv8\nWITH_EXCEPTION=ON\nWITH_EXTRA=ON/' ./tools/build_linux.sh

# Execute the build script
RUN ./tools/build_linux.sh
