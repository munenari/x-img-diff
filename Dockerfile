
FROM debian:10-slim

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        libopencv-dev build-essential cmake && \
    apt clean

WORKDIR /x
COPY . /x

WORKDIR /build
RUN cmake /x && make install

RUN apt purge -y \
        cmake build-essential && \
    apt autoremove -y && \
    rm -rf /x
WORKDIR /x

ENTRYPOINT [ "/usr/local/bin/ximgdiff" ]
CMD [ "--help" ]
