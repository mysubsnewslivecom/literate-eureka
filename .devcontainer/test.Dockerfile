ARG BASE_IMAGE_NAME=python
ARG BASE_IMAGE_TAG=3.10

FROM ${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG}

ARG USERNAME=linux
ARG USER_UID=1000
ARG USER_GID=$USER_UID

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
    procps \ 
    neovim \
    lsb-release \
    libzip-dev \
    libpq-dev \
    less \
    iproute2 \    
    git \
    fzf \
    ca-certificates \
    build-essential \
    apt-transport-https

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog sudo 2>&1 \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# Clean up
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME
