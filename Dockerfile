FROM alpine:3.18

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
  numpy==1.20.3 \
  pandas==2.0.0 \
  bcrypt==3.1.6 \
  Flask==2.3.2 \
  flask-restful==0.3.7 \
  flask_cors==3.0.9 \
  Jinja2==3.1.2 \
  gunicorn==20.1.0 \
  python-dotenv==0.19.1 \
  pymongo==4.2.0 \
  gevent==23.7.0 \
  SQLAlchemy==2.0.19 \
  flask_jwt==0.3.2 \
  flask_mail==0.9.1 \
  requests==2.21.0 \
  celery==5.1.2 \
  plotly==5.8.0 \
  pytest==6.2.2 \
  black==19.3b0 \ 
  flake8==3.7.7 \
  pdoc3==0.6.2 \
  cx-Oracle==7.1.3 \
  google-auth==1.6.3 \
  pycurl==7.43.0.6 \
  dnspython=2.4.1 \
  calmap==0.0.11 \ 
  calplot==0.1.7.5 \
  plotly-calplot==0.1.16 \
  celery==5.1.0b1 \ 
  redis==4.3.4 \
  sentry-sdk[flask] \
  "

RUN apk add --no-cache python3-dev py-pip\
  && apk add --no-cache $PACKAGES \
  && apk add build-base openblas-dev freetype-dev pkgconfig gfortran \
  && ln -s /usr/include/locale.h /usr/include/xlocale.h \
  && pip3 install --upgrade pip \
  && pip3 install --no-cache-dir $PYTHON_PACKAGES \
  && rm -rf /var/cache/apk/*
