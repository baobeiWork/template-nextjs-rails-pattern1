FROM node:latest

# Define build arguments
ARG SYSTEM_NAME
ARG SYSTEM_DOMAIN
ARG NEXT_ENV
ARG NEXT_PUBLIC_API_URL
ARG NEXT_PUBLIC_IS_API_MOCKED

# Define environment variables
ENV TIME_ZONE='Asia/Tokyo' \
    SYSTEM_NAME=${SYSTEM_NAME} \
    SYSTEM_DOMAIN=${SYSTEM_DOMAIN} \
    NEXT_ENV=${NEXT_ENV} \
    NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL} \
    NEXT_PUBLIC_IS_API_MOCKED=${NEXT_PUBLIC_IS_API_MOCKED} 

RUN apt-get update && apt-get install -y \
    vim \
    curl \
    yarn \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /${SYSTEM_NAME}

# Copy package.json and yarn.lock
COPY ./frontend/package.json ./frontend/yarn.lock ./

# Copy the rest of the application code
COPY ./frontend ./

# Copy shell scripts and make them executable
COPY ./infrastructure/shell/frontend/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/*

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 8000