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
    Flask==1.0.2 \
    flask-restful==0.3.7 \
    flask_cors==3.0.7 \
    gunicorn==19.9.0 \
    python-dotenv==0.10.1 \
    pymongo==3.7.2 \
    flask_jwt==0.3.2 \
    flask_mail==0.9.1 \
    requests==2.21.0 \
    celery==4.3.0 \
    plotly==3.8.0 \
    cufflinks==0.15 \
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