FROM debian:stretch
LABEL maintainer="Rheix Developers <dev@rheixverse.com>"
LABEL description="Dockerised RheixCore, built from Travis"

RUN apt-get update && apt-get -y upgrade && apt-get clean && rm -fr /var/cache/apt/*

COPY bin/* /usr/bin/
