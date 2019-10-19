# Omada Controller Docker

*Omada controller bundled in a Docker image*

[![omada](https://github.com/qdm12/omada/raw/master/title.png)](https://hub.docker.com/r/qmcgaw/omada)

[![Docker Build Status](https://img.shields.io/docker/cloud/build/qmcgaw/omada.svg)](https://hub.docker.com/r/qmcgaw/omada)

[![GitHub last commit](https://img.shields.io/github/last-commit/qdm12/omada.svg)](https://github.com/qdm12/omada/issues)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/y/qdm12/omada.svg)](https://github.com/qdm12/omada/issues)
[![GitHub issues](https://img.shields.io/github/issues/qdm12/omada.svg)](https://github.com/qdm12/omada/issues)

[![Docker Pulls](https://img.shields.io/docker/pulls/qmcgaw/omada.svg)](https://hub.docker.com/r/qmcgaw/omada)
[![Docker Stars](https://img.shields.io/docker/stars/qmcgaw/omada.svg)](https://hub.docker.com/r/qmcgaw/omada)
[![Docker Automated](https://img.shields.io/docker/cloud/automated/qmcgaw/omada.svg)](https://hub.docker.com/r/qmcgaw/omada)

[![Image size](https://images.microbadger.com/badges/image/qmcgaw/omada.svg)](https://microbadger.com/images/qmcgaw/omada)
[![Image version](https://images.microbadger.com/badges/version/qmcgaw/omada.svg)](https://microbadger.com/images/qmcgaw/omada)

| Image size | RAM usage | CPU usage |
| --- | --- | --- |
| 371MB | 350MB | Low |

It is based on:

- [Debian Buster Slim](https://hub.docker.com/_/debian)
- [Omada controller software](https://www.tp-link.com/us/support/download/eap-controller/#Controller_Software)

## Setup

1. Create directories and set their permissions:

    ```sh
    mkdir logs data
    chown 1000 logs data
    chmod 700 logs data
    ```

1. Use the following command:

    ```sh
    docker run -d \
    -p 8080:8080/tcp -p 8043:8043/tcp \
    -p 27001:27001/udp -p 27002:27002/tcp \
    -p 29810:29810/udp -p 29811:29811/tcp -p 29812:29812/tcp -p 29813:29813/tcp \
    -v $(pwd)/logs:/omada/logs -v $(pwd)/data:/omada/data \
    qmcgaw/omada
    ```

    or use [docker-compose.yml](https://github.com/qdm12/omada/blob/master/docker-compose.yml) with:

    ```sh
    docker-compose up -d
    ```

### Environment variables

| Environment variable | Default | Possible values | Description |
| --- | --- | --- | --- |
| HTTPPORT | `8080` | Port from `1025` to `65535` | Internal HTTP port, useful for redirection |
| HTTPSPORT | `8043` | Port from `1025` to `65535` | Internal HTTPS port, useful for redirection |

### Notes

- It is useful to change the HTTPSPORT as Omada redirects you to its internal `HTTPSPORT`.
So if you want to run the container with `-p 8000:8000` for the HTTPS port, you need to set `HTTPSPORT=8000`.
- From [TP Link Omada's FAQ](https://www.tp-link.com/us/support/faq/865), Omada controller uses the ports:
    - 8043 (TCP) for https
    - 8088 (TCP) for http
    - 27001 (UDP) for controller discovery
    - 27002 (TCP) for controller searching
    - ~27017 (TCP) for mongo DB server~ (internally)
    - 29810 (UDP) for EAP discovery
    - 29811 (TCP) for EAP management
    - 29812 (TCP) for EAP adoption
    - 29813 (TCP) for EAP upgrading

## TODOs

- [ ] Healthcheck
- [ ] Instructions with proxy and port redirection
