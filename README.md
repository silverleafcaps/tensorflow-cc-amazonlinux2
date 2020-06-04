# tensorflow-cc-amazonlinux2

This repository contains the Dockerfiles required to create a Docker Image containing Tensorflow C++ Shared API using [FloopCZ/tensorflow_cc](https://github.com/FloopCZ/tensorflow_cc) for [amazonlinux:2](https://hub.docker.com/_/amazonlinux). The tags will based on the tensorflow version that was built.

## Docker

If you wish to start using this project right away, fetch a prebuilt image on [Docker Hub](https://hub.docker.com/r/keivansl/tf-cc)!

```bash
docker run -it keivansl/tf-cc:v1.15 /bin/bash
```

To build the image yourself, clone this repo and on a terminal inside this repo run:

```bash
git checkout <TAG> # The version you are looking to build.
docker build -t keivansl/tf-cc .
```

To upload the image to Dockerhub ensure you have the credentials configured properly.

```bash
docker image tag <IMAGE ID> keivansl/tf-cc:<VERSION TAG>
docker push keivansl/tf-cc:<VERSION TAG>
```

