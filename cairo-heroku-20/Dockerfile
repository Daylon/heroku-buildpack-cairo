FROM daylon/heroku-20-stack

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get upgrade -y

ADD ./harfbuzz.tar.bz2 /tmp
ADD ./freetype.tar.bz2 /tmp
ADD ./pixman.tar.gz /tmp
ADD ./giflib.tar.bz2 /tmp
ADD ./fontconfig.tar.bz2 /tmp
ADD ./cairo.tar.xz /tmp
ADD ./pango.tar.xz /tmp
ADD ./librsvg.tar.xz /tmp

RUN \
  cd /tmp/harfbuzz-* && \
  ./configure --prefix=/app/vendor/harfbuzz && \
  make install

ENV PKG_CONFIG_PATH /app/vendor/harfbuzz/lib/pkgconfig

RUN \
  cd /tmp/freetype-* && \
  ./configure --prefix=/app/vendor/freetype && \
  make && \
  make install

RUN \
  cd /tmp/pixman-* && \
  ./configure --prefix=/app/vendor/pixman && \
  make install

RUN \
  cd /tmp/giflib-* && \
  ./configure --prefix=/app/vendor/giflib && \
  make install-exec install-data

RUN \
  cd /tmp/fontconfig-* && \
  ./configure --prefix=/app/vendor/fontconfig && \
  make install

RUN \
  cd /tmp/cairo-* && \
  ./configure --prefix=/app/vendor/cairo && \
  make install

RUN \
  cd /tmp/pango-* && \
  ./configure --prefix=/app/vendor/pango && \
  make install

RUN \
  cd /tmp/librsvg-* && \
  ./configure --prefix=/app/vendor/librsvg && \
  make install

RUN \
  cd /app/vendor/pixman && \
  tar zcf /tmp/pixman-heroku-20.tar.gz . && \
  cd /app/vendor/freetype && \
  tar zcf /tmp/freetype-heroku-20.tar.gz . && \
  cd /app/vendor/giflib && \
  tar zcf /tmp/giflib-heroku-20.tar.gz . && \
  cd /app/vendor/fontconfig && \
  tar zcf /tmp/fontconfig-heroku-20.tar.gz . && \
  cd /app/vendor/cairo && \
  tar zcf /tmp/cairo-heroku-20.tar.gz . && \
  cd /app/vendor/harfbuzz && \
  tar zcf /tmp/harfbuzz-heroku-20.tar.gz . && \
  cd /app/vendor/pango && \
  tar zcf /tmp/pango-heroku-20.tar.gz .
  cd /app/vendor/librsvg && \
  tar zcf /tmp/librsvg-heroku-20.tar.gz .
