FROM ubuntu:18.04

ENV \
    GETH_RELEASE=1.8.22-7fa3509e \
    GETH_ARCH=amd64 \
    GETH_MD5=a02321a1ee89c330eb8e87b694254dbb

RUN \
    GETH_BUILD=geth-linux-$GETH_ARCH-$GETH_RELEASE && \
    GETH_BUILD_FILE=geth-linux-$GETH_ARCH-$GETH_RELEASE.tar.gz && \
    GETH_URL=https://gethstore.blob.core.windows.net/builds/$GETH_BUILD_FILE && \
    apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates gosu && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -r ethereum && \
    cd /tmp && \
    curl -O $GETH_URL && \
    echo "$GETH_MD5 $GETH_BUILD_FILE" | md5sum -c && \
    tar --extract --gzip --file $GETH_BUILD_FILE && \
    mv $GETH_BUILD/geth /usr/local/bin/ && \
    rm -rf $GETH_BUILD_FILE $GETH_BUILD

EXPOSE 8545 8546

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
