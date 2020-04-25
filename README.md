# gerrit developer docker images based on Alpine Linux and Ubuntu

To pull the prebuilt image from docker hub for Alpine Linux:

```
$ docker pull davido42/bazel-build-gerrit:v0.9.0
```

To pull the prebuilt image from docker hub for Ubuntu 20.04:

```
$ docker pull davido42/bazel-build-gerrit-ubuntu:latest
```

To build the Alpine Linux image:

```
$ docker build --no-cache=false -t davido42/bazel-build-gerrit .
```

To build the Ubuntu image:

```
$ docker build --no-cache=false -f Dockerfile.ubuntu -t davido42/bazel-build-gerrit-ubuntu .
```

To run the Alpine Linux image:

```
$ docker run -ti davido42/bazel-build-gerrit
```

To run the Ubuntu image:

```
$ docker run -ti davido42/bazel-build-gerrit-ubuntu
```

To mount the host gerrit and cache directories:

```
$ docker run -ti -v ~/.gerritcodereview/bazel-cache/downloaded-artifacts:/home/builder/.gerritcodereview/bazel-cache/downloaded-artifacts -v ~/.gerritcodereview/bazel-cache/cas:/home/builder/.gerritcodereview/bazel-cache/cas -v ~/.gerritcodereview/bazel-cache/repository:/home/builder/.gerritcodereview/bazel-cache/repository -v ~/projects/gerrit:/home/builder/gerrit davido42/bazel-build-gerrit
```

To build gerrit:

```
$ git clone --recursive https://gerrit.googlesource.com/gerrit
$ cd gerrit
$ bazel build release
```
