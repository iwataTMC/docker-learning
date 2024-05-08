#!/bin/bash -eu
docker run -ti --rm --name network -p 8888:8888 network:latest /bin/bash
# docker -v /Users/<host user>/<user-dir>:/home/<docker user>/<docker-user-dir> -ti --rm --name network -p 8888:8888 network:latest /bin/bash
