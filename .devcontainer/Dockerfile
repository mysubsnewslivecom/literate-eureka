ARG BASE_IMAGE_NAME=python
ARG BASE_IMAGE_TAG=3.10

FROM ${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG}

ARG USER=linux
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG GROUP=$USER

# set environment variables
ENV C_FORCE_ROOT=true \
    DEBIAN_FRONTEND=noninteractive \
    DJANGO_ENV=${DJANGO_ENV} \
    # python:
    PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    # pip:
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100
    # user
    GROUP=$USER
    HOME=/home/$USER

RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    vim \
    gettext \
    unzip \
    sudo \
    software-properties-common \
    neovim \
    libzip-dev \
    libpq-dev \
    git \
    fzf \
    ca-certificates \
    build-essential \
    apt-transport-https \
    && apt-get autoremove -y \
    && apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd --gid $USER_GID $USER \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USER 

# Add non-root user
# RUN groupadd ${GROUP} && useradd -s /bin/bash --create-home --home-dir ${HOME} -g ${GROUP} ${USER}

## Make sure to reflect new user in PATH
ENV PATH="/home/${USER}/.local/bin:${PATH}"

USER $USER

## Pip dependencies
# Upgrade pip
RUN pip install --upgrade pip --no-cache-dir

# Install production dependencies
COPY --chown=${USER}:${GROUP} requirements.txt /tmp/requirements.txt

WORKDIR /workspaces

RUN pip install -r /tmp/requirements.txt --no-cache-dir && \
    rm /tmp/requirements.txt

ENTRYPOINT [ "mkdocs", "serve", "-a", "0.0.0.0:4000" ]
