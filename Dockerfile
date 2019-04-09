FROM alpine:3.8

LABEL MAINTAINER="Ahmed Saleh <a.saleh.ismael@gmail.com>"

WORKDIR /var/www/

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
    libssl1.0 \
    libffi-dev \
    "
ENV PYTHON_PACKAGES="\
    numpy \
    pandas \
    bcrypt \
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