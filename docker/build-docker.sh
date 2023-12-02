#!/usr/bin/env bash

export LC_ALL=C

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/.. || exit

DOCKER_IMAGE=${DOCKER_IMAGE:-rheix/rheixd-develop}
DOCKER_TAG=${DOCKER_TAG:-latest}

BUILD_DIR=${BUILD_DIR:-.}

rm docker/bin/*
mkdir docker/bin
cp $BUILD_DIR/src/rheixd docker/bin/
cp $BUILD_DIR/src/rheix-cli docker/bin/
cp $BUILD_DIR/src/rheix-tx docker/bin/
strip docker/bin/rheixd
strip docker/bin/rheix-cli
strip docker/bin/rheix-tx

docker build --pull -t $DOCKER_IMAGE:$DOCKER_TAG -f docker/Dockerfile docker
