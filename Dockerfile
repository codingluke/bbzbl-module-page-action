# Container image that runs your code
FROM node:lts-slim

ADD vuepress /vuepress
WORKDIR /vuepress

RUN apt-get -y update \
  && apt-get -y install git \
  && corepack enable \
  && yarn set version stable \
  && yarn install \
  && npm install -g @marp-team/marp-cli@1.4.0

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
