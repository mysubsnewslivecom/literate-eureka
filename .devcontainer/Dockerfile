ARG BASE_IMAGE_NAME=python
ARG BASE_IMAGE_TAG=3.10

FROM ${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG}

ENV C_FORCE_ROOT true
# ENV USERNAME=linux
# ENV GROUP=linux

ARG USERNAME=linux
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ENV HOME /home/${USERNAME}

# Add non-root user
RUN groupadd ${GROUP} && useradd -s /bin/bash --create-home --home-dir ${HOME} -g ${GROUP} ${USERNAME}

## Make sure to reflect new user in PATH
ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    vim \
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
    && rm -rf /var/lib/apt/lists/*

USER $USERNAME

## Pip dependencies
# Upgrade pip
RUN pip install --upgrade pip --no-cache-dir

# Install production dependencies
COPY --chown=${USERNAME}:${GROUP} requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt --no-cache-dir && \
    rm /tmp/requirements.txt
