# Docker image of SteamOS Holo from SteamDeckHomebrew
FROM ghcr.io/steamdeckhomebrew/holo-base:latest

# Set NVM_DIR directory and node version
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION v21.6.2

# Make sure $NVM_DIR directory exists
RUN mkdir -p $NVM_DIR

# Install nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.7/install.sh | bash

# Install node
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install --latest-npm $NODE_VERSION && nvm use --delete-prefix $NODE_VERSION"

# Set the environment variables
ENV NODE_PATH $NVM_DIR/versions/node/$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH

# Set the backend directory as the working directory
WORKDIR /backend

# Set the entrypoint
ENTRYPOINT [ "/backend/entrypoint.sh" ]
