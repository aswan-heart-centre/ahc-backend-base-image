FROM alpine:3.13

LABEL MAINTAINER="Ahmed Saleh <a.saleh.ismael@gmail.com>"

WORKDIR /var/www/

ENV PYCURL_SSL_LIBRARY=openssl

ENV PACKAGES="\
  dumb-init \
  musl \
  libc6-compat \
  linux-headers \
  build-base \
  bash \
  git \
  ca-certificates \
  freetype \
  libgfortran \
  libgcc \
  libstdc++ \
  openblas \
  libffi-dev \
  libcurl \
  curl-dev \
  "
ENV PYTHON_PACKAGES="\
  numpy==1.19.5 \
  pandas==1.2.3 \
  bcrypt==3.1.6 \
  Flask==1.0.2 \
  flask-restful==0.3.7 \
  flask_cors==3.0.9 \
  gunicorn==20.0.1 \
  python-dotenv==0.10.1 \
  pymongo==3.7.2 \
  flask_jwt==0.3.2 \
  flask_mail==0.9.1 \
  requests==2.21.0 \
  celery==4.3.0 \
  plotly==4.14.3 \
  pytest==4.5.0 \
  black==19.3b0 \
  flake8==3.7.7 \
  pdoc3==0.6.2 \
  cx-Oracle==7.1.3 \
  google-auth==1.6.3 \
  pycurl==7.43.0.6 \
  "

RUN apk add --no-cache --virtual build-dependencies python3-dev \
  && apk add --no-cache --virtual build-dependencies $PACKAGES \
  && apk add --virtual build-runtime \
  build-base openblas-dev freetype-dev pkgconfig gfortran \
  && ln -s /usr/include/locale.h /usr/include/xlocale.h \
  && pip3 install --upgrade pip \
  && pip3 install --no-cache-dir $PYTHON_PACKAGES \
  && apk del build-runtime \
  && rm -rf /var/cache/apk/*
