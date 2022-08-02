FROM ubuntu:22.10 as build

RUN set -o errexit -o nounset \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
      git \
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
  && make server


FROM ubuntu:22.10

COPY --from=build /tmp/build/antnium/server.elf /
COPY --from=build /tmp/build/antnium/webui /webui

EXPOSE 8080

ENTRYPOINT ["./server.elf"]

