#!/bin/bash -eu
docker run -ti --rm --name network -p 8888:8888 network:latest /bin/bash
# docker run -v /Users/<host user>/<host-dir-name>:/home/<docker user>/<docker-dir-name> -ti --rm --name network -p 8888:8888 network:latest /bin/bash
