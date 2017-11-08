# gerrit developer docker image based on Alpine Linux

To pull the prebuilt image from docker hub:

```
$ docker pull davido42/bazel-build-gerrit
```

To build the image:

```
$ docker build --no-cache=false -t davido42/bazel-build-gerrit .
```

To run the image:

```
$ docker run -ti davido42/bazel-build-gerrit
```

To mount the host gerrit and cache directories:

```
$ docker run -ti -v ~/.gerritcodereview/buck-cache/downloaded-artifacts:/opt/downloaded-artifacts  -v ~/.gerritcodereview/bazel-cache/cas:/opt/cas -v ~/projects/gerrit2:/opt/gerrit davido42/bazel-build-gerrit
```

To build gerrit:

```
$ git clone --recursive https://gerrit.googlesource.com/gerrit
$ cd gerrit
$ bazel build release
```
