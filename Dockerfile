FROM alpine:latest
MAINTAINER Alan Bondarchuk <imacoda@gmail.com>

RUN apk upgrade --update && apk add nodejs libc6-compat libstdc++ libgcc libxrender dbus firefox-esr fontconfig python ttf-freefont xvfb && \
  npm install -g npm && \
  apk del curl make gcc g++ linux-headers paxctl gnupg && \

  # Install packages
  npm install -g util slimerjs casperjs@1.1-beta5 && \

  # Remove unused
  rm -rf /etc/ssl /SHASUMS256.txt.asc /usr/include \
    /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp /root/.gnupg \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

# Create user www-data
RUN addgroup -g 82 -S www-data && \
	adduser -u 82 -D -S -G www-data www-data

# Create work dir
RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www

WORKDIR /var/www/html
VOLUME /var/www/html
EXPOSE 8080

CMD ["casperjs", "--engine", "slimerjs"]
