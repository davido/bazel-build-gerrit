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
$ docker run -ti -v ~/.gerritcodereview/buck-cache/downloaded-artifacts:/home/builder/.gerritcodereview/buck-cache/downloaded-artifacts -v ~/.gerritcodereview/bazel-cache/cas:/home/builder/.gerritcodereview/bazel-cache/cas -v ~/projects/gerrit2:/home/builder/gerrit davido42/bazel-build-gerrit
```

To build gerrit:

```
$ git clone --recursive https://gerrit.googlesource.com/gerrit
$ cd gerrit
$ bazel build release
```
