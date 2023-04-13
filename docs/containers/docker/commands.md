---
title: Commands
---

### Create mkdocs image

```sh
docker build . -f Dockerfile -t mkdocs:0.1  \
    --build-arg USERNAME=linux \
    --build-arg USER_UID=1000 \
    --build-arg BASE_IMAGE_NAME=python \
    --build-arg BASE_IMAGE_TAG=3.10
```

### Docker run

```sh
docker run -it --rm -d --name mkdocs-local -p 4000:4000 -v ${PWD}:/workspaces mkdocs:0.1
```
