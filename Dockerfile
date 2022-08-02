FROM ubuntu:22.10

RUN set -o errexit -o nounset \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
      git \
      vim \
      golang \
      gcc-mingw-w64 \
      make \
      build-essential \
      apt-transport-https \
      ca-certificates

RUN set -o errexit -o nounset \
  && mkdir -p /tmp/build \
  && cd /tmp/build \ 
  && git clone https://github.com/dobin/antnium.git

RUN set -o errexit -o nounset \
  && cd /tmp/build/antnium \
  && make server \
  && make client \
  && make wingman

