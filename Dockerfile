# syntax=docker/dockerfile:1.4

# base image
FROM ghcr.io/cidverse/image-base:main

# just for testing
ENV HELM_VERSION=v3.8.1 \
    BUILD_OS=linux \
    ABUILD_ARCH=amd64

# install
RUN --mount=type=cache,target=/var/cache \
    do-install git wget &&\
    do-download "https://get.helm.sh/helm-${HELM_VERSION}-${BUILD_OS}-${ABUILD_ARCH}.tar.gz" "$CACHE_DOWNLOAD/${HELM_VERSION}_${BUILD_OS}_${ABUILD_ARCH}.tar.gz" &&\
    do-untar "$CACHE_DOWNLOAD/${HELM_VERSION}_${BUILD_OS}_${ABUILD_ARCH}.tar.gz" "$CACHE_EXTRACT/${HELM_VERSION}_${BUILD_OS}_${ABUILD_ARCH}" &&\
    cp "$CACHE_EXTRACT/${HELM_VERSION}_${BUILD_OS}_${ABUILD_ARCH}/${BUILD_OS}-${ABUILD_ARCH}/helm" "/usr/local/bin/helm" &&\
    chmod 755 /usr/local/bin/helm

# permissions
USER 1001
