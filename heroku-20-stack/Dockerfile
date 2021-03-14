FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

# Initialize heroku-20 stack
ADD ./heroku-20.sh /tmp/heroku-20.sh
RUN \
  /bin/bash /tmp/heroku-20.sh

RUN \
  apt-get upgrade -y
