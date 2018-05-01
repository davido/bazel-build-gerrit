FROM alpine:latest

MAINTAINER davido

ENV BAZEL_VERSION 0.13.0
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

RUN apk add --no-cache --virtual=.build-deps \
    coreutils \
    ca-certificates \
    wget \
    git \
    go \
    perl \
    python \
    python-dev \
    nodejs \
    nodejs-npm \
    openssh \
    bash \
    curl \
    g++ \
    musl-dev \
    openjdk8 \
    sudo \
    sed \
    zip \
    libarchive \
    unzip \
    \
    && ln -s /usr/lib/jvm/java-1.8-openjdk/bin/javac /usr/bin \
    && ln -s /usr/lib/jvm/java-1.8-openjdk/bin/jar /usr/bin \
    \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.26-r0/glibc-2.26-r0.apk \
    && apk add glibc-2.26-r0.apk \
    \
    && wget -q -O /etc/apk/keys/david@ostrovsky.org-5a0369d6.rsa.pub https://raw.githubusercontent.com/davido/bazel-alpine-package/master/david@ostrovsky.org-5a0369d6.rsa.pub \
    && wget https://github.com/davido/bazel-alpine-package/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-r0.apk \
    && apk add bazel-${BAZEL_VERSION}-r0.apk \
    \
    && npm config set user 0 \
    && npm config set unsafe-perm true \
    && npm install -g \
    eslint \
    eslint-config-google \
    eslint-plugin-html \
    typescript \
    fried-twinkie \
    polylint \
    web-component-tester \
    \
    && adduser -D builder -s /bin/bash \
    && echo "builder    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY .* /home/builder/
RUN chown builder:builder /home/builder/.*

RUN mkdir -p /home/builder/.gerritcodereview/bazel-cache/cas \
    && mkdir -p /home/builder/.gerritcodereview/bazel-cache/repository \
    && mkdir -p /home/builder/.gerritcodereview/buck-cache/downloaded-artifacts

USER builder

RUN mkdir -p /home/builder/gerrit

WORKDIR /home/builder/gerrit

# Extract instaled bazel version (warm up bazel installation)
# TODO(davido): check why this is causing problem with rules_closur
RUN bazel version

ENTRYPOINT ["bash"]
