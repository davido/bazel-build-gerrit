# gerrit developer docker image based on Alpine Linux

To pull the prebuilt image from docker hub:

```
$ docker pull davido42/bazel-build-gerrit
```

[Optional] To build the image:

```
$ docker build --no-cache=false -t davido42/bazel-build-gerrit .
```

To run the image:

```
$ docker run --privileged -ti --entrypoint=bash davido42/bazel-build-gerrit
```

Optionaly: mount the host gerrit directory and cache directories:

```
$ docker run --privileged -ti --entrypoint=bash -v ~/.gerritcodereview/buck-cache/downloaded-artifacts:/opt/downloaded-artifacts  -v ~/.gerritcodereview/bazel-cache/cas:/opt/cas -v ~/projects/gerrit2:/opt/gerrit davido42/bazel-build-gerrit
```

To create developer user in container execute as root:

```
$ adduser -D -s /bin/bash <user>
$ su - <user>
```

To build gerrit run as developer user:

```
$ git clone --recursive https://gerrit.googlesource.com/gerrit
$ cd gerrit
$ bazel build release
```
