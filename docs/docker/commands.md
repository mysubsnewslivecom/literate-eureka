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
