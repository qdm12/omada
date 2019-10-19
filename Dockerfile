ARG BASE_IMAGE=debian
ARG DEBIAN_VERSION=buster-slim

FROM ${BASE_IMAGE}:${DEBIAN_VERSION}
ARG BUILD_DATE
ARG VCS_REF
ARG OMADA_VERSION=3.2.1
ARG RELEASE_DATE=20190906
LABEL \
    org.opencontainers.image.authors="quentin.mcgaw@gmail.com" \
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.version=$OMADA_VERSION \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.url="https://github.com/qdm12/omada" \
    org.opencontainers.image.documentation="https://github.com/qdm12/omada/blob/master/README.md" \
    org.opencontainers.image.source="https://github.com/qdm12/omada" \
    org.opencontainers.image.title="omada" \
    org.opencontainers.image.description="Omada controller on Alpine" \
    image-size="354MB" \
    ram-usage="350MB" \
    cpu-usage="Low"
EXPOSE 8088/tcp 8043/tcp 27001/udp 27002/tcp 29810/udp 29811/tcp 29812/tcp 29813/tcp
ENV HTTPPORT=8088 \
    HTTPSPORT=8043
WORKDIR /omada
COPY entrypoint.sh .
ENTRYPOINT /omada/entrypoint.sh
RUN apt-get update -y > /dev/null && \
    apt-get install -y libcap-dev wget net-tools > /dev/null && \
    RELEASE_YEAR=`echo "${RELEASE_DATE}" | cut -c1-4` && \
    RELEASE_YEARMONTH=`echo "${RELEASE_DATE}" | cut -c1-6` && \
    wget -q "https://static.tp-link.com/${RELEASE_YEAR}/${RELEASE_YEARMONTH}/${RELEASE_DATE}/Omada_Controller_v${OMADA_VERSION}_linux_x64.tar.gz" -O omada.tar.gz && \
    apt-get purge -y wget > /dev/null && \
    apt-get autoremove -y > /dev/null && \
    rm -rf /var/lib/apt/lists/* && \
    tar -xf omada.tar.gz --strip-components=1 && \
    rm omada.tar.gz && \
    groupadd -g 1000 omada && \
    useradd -u 1000 -g 1000 -d /omada omada && \
    rm -rf /var/cache/apk/* && \
    rm readme.txt install.sh uninstall.sh && \
    mkdir -p logs work && \
    chown -R omada:omada . && \
    chmod 500 entrypoint.sh bin/* jre/bin/* && \
    chmod 700 logs work
USER omada