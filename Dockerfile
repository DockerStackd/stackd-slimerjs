FROM ubuntu:14.04

MAINTAINER Alan Bondarchuk <imacoda@gmail.com>

# Env
ENV SLIMERJS_VERSION_F 0.10.1
ENV CASPERJS_VERSION_F 1.1.3

# Commands
RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y unzip git wget xvfb libxrender-dev libasound2 libdbus-glib-1-2 libgtk2.0-0 bzip2 python firefox && \
  mkdir -p /srv/var && \
  wget -O /tmp/slimerjs-$SLIMERJS_VERSION_F.zip http://download.slimerjs.org/releases/$SLIMERJS_VERSION_F/slimerjs-$SLIMERJS_VERSION_F.zip && \
  unzip /tmp/slimerjs-$SLIMERJS_VERSION_F.zip -d /tmp && \
  rm -f /tmp/slimerjs-$SLIMERJS_VERSION_F.zip && \
  mv /tmp/slimerjs-$SLIMERJS_VERSION_F/ /srv/var/slimerjs && \
  echo '#!/bin/bash\nxvfb-run /srv/var/slimerjs/slimerjs "$@"' > /srv/var/slimerjs/slimerjs.sh && \
  chmod 755 /srv/var/slimerjs/slimerjs.sh && \
  ln -s /srv/var/slimerjs/slimerjs.sh /usr/bin/slimerjs && \
  wget -O /tmp/casperjs-$CASPERJS_VERSION_F.zip https://github.com/casperjs/casperjs/archive/$CASPERJS_VERSION_F.zip
  unzip /tmp/casperjs-$CASPERJS_VERSION_F.zip -d /tmp && \
  rm -f /tmp/casperjs-$CASPERJS_VERSION_F.zip && \
  mv /tmp/slimerjs-$CASPERJS_VERSION_F/ /srv/var/casperjs && \
  echo '#!/bin/bash\n/srv/var/casperjs/bin/casperjs --engine=slimerjs "$@"' >> /srv/var/casperjs/casperjs.sh && \
  chmod 755 /srv/var/casperjs/casperjs.sh && \
  ln -s /srv/var/casperjs/casperjs.sh /usr/bin/casperjs && \
  apt-get autoremove -y && \
  apt-get clean all

# Default command
CMD ["/usr/bin/slimerjs"]