FROM alpine:3.6

MAINTAINER davido

RUN apk add --no-cache --virtual=.build-deps \
    git \
    go \
    python \
    python-dev \
    nodejs \
    nodejs-npm \
    openssh \
    bash \
    curl \
    g++ \
    linux-headers \
    make \
    musl-dev \
    openjdk8 \
    sed \
    zip

# Install glibc: https://github.com/bazelbuild/rules_closure/issues/228
RUN apk --no-cache add ca-certificates wget \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.26-r0/glibc-2.26-r0.apk \
    && apk add glibc-2.26-r0.apk

# Install Bazel from source: https://github.com/bazelbuild/bazel/issues/4034
ENV BAZEL_VERSION 0.8.0rc1
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

# curl -SLO https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-dist.zip \
RUN curl -SLO https://releases.bazel.build/0.8.0/rc1/bazel-0.8.0rc1-dist.zip \
    && mkdir bazel-${BAZEL_VERSION} \
    && unzip -qd bazel-${BAZEL_VERSION} bazel-${BAZEL_VERSION}-dist.zip \
    && cd bazel-${BAZEL_VERSION} \
    && bash compile.sh \
    && cp -p output/bazel /usr/bin/

# Add links to javac and jar
RUN cd /usr/bin \
    && ln -s /usr/lib/jvm/java-1.8-openjdk/bin/javac . \
    && ln -s /usr/lib/jvm/java-1.8-openjdk/bin/jar .
