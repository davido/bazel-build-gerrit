FROM alpine:latest

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
    musl-dev \
    openjdk8 \
    sudo \
    sed \
    zip \
    libarchive \
    unzip

# Add links to javac and jar
RUN cd /usr/bin \
    && ln -s /usr/lib/jvm/java-1.8-openjdk/bin/javac . \
    && ln -s /usr/lib/jvm/java-1.8-openjdk/bin/jar .

# Install glibc: https://github.com/bazelbuild/rules_closure/issues/228
RUN apk --no-cache add ca-certificates wget \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.26-r0/glibc-2.26-r0.apk \
    && apk add glibc-2.26-r0.apk

# Install Bazel
ENV BAZEL_VERSION 0.7.0

RUN wget -q -O /etc/apk/keys/david@ostrovsky.org-5a0369d6.rsa.pub https://raw.githubusercontent.com/davido/bazel-alpine-package/master/david@ostrovsky.org-5a0369d6.rsa.pub \
    && wget https://github.com/davido/bazel-alpine-package/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-r1.apk \
    && apk add bazel-${BAZEL_VERSION}-r1.apk

RUN adduser -D builder -s /bin/bash \
    && echo "builder    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
	
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

COPY .bazelrc /home/builder/.bazelrc
RUN chown builder:builder /home/builder/.bazelrc

RUN mkdir -p /home/builder/.gerritcodereview/bazel-cache/cas
RUN mkdir -p /home/builder/.gerritcodereview/buck-cache/downloaded-artifacts 

USER builder

RUN mkdir -p /home/builder/gerrit

WORKDIR /home/builder/gerrit

# Extract instaled bazel version (warm up bazel installation)
RUN bazel version

ENTRYPOINT ["bash"]
