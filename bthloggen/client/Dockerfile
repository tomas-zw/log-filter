FROM ubuntu:22.04

RUN apt update && \
    apt -y install jq curl

WORKDIR /kmom10

COPY bthloggen.bash ./

COPY server.txt ./
