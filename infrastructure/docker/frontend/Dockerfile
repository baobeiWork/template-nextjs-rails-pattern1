# infrastructure/docker/frontend/Dockerfile
FROM node:latest

RUN apt-get update && apt-get install -y \
    vim \
    curl \
    yarn \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /asset_compass

# Copy package.json and yarn.lock
COPY ./frontend/package.json ./frontend/yarn.lock ./

# Copy the rest of the application code
COPY ./frontend ./

# Copy shell scripts and make them executable
COPY ./infrastructure/docker/frontend/shell/* /usr/bin/
RUN chmod +x /usr/bin/*

EXPOSE 8000
ENTRYPOINT ["entrypoint.sh"]
