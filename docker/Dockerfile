FROM arm64v8/ubuntu:20.04

# Set the working directory
WORKDIR /workspace

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

WORKDIR /Paddle-Lite

# Change parameters in the build script
RUN sed -i 's/ARCH=armv8/ARCH=armv8\nWITH_EXCEPTION=ON\nWITH_EXTRA=ON/' ./lite/tools/build_linux.sh

# Execute the build script
RUN ./lite/tools/build_linux.sh
