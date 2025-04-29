FROM ruby:3.3.3

# Define build arguments
ARG SYSTEM_NAME
ARG SYSTEM_DOMAIN
ARG DATABASE_USER
ARG DATABASE_PASSWORD
ARG DATABASE_NAME
ARG DATABASE_HOST
ARG RAILS_ENV
ARG RAILS_MASTER_KEY
ARG RAILS_SECRET_KEY_BASE

# Define environment variables
ENV BUNDLER_VERSION=2.5.14 \
    APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 \
    TIME_ZONE='Asia/Tokyo' \
    RAILS_ENV=${RAILS_ENV} \
    SYSTEM_NAME=${SYSTEM_NAME} \
    SYSTEM_DOMAIN=${SYSTEM_DOMAIN} \
    DATABASE_USER=${DATABASE_USER} \
    DATABASE_PASSWORD=${DATABASE_PASSWORD} \
    DATABASE_NAME=${DATABASE_NAME} \
    DATABASE_HOST=${DATABASE_HOST} \
    RAILS_MASTER_KEY=${RAILS_MASTER_KEY} \
    RAILS_SECRET_KEY_BASE=${RAILS_SECRET_KEY_BASE}

RUN apt-get update && apt-get install -y \
    vim \
    curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Create Work Dir and Documents Dir
RUN mkdir -p /document/swagger
WORKDIR /backend

# Install Bundler and Rails
RUN gem install bundler -v "${BUNDLER_VERSION}" && \
    gem install rails

# Copy Gemfile and Gemfile.lock
COPY ./backend/Gem* /backend/

# Run bundle install
RUN bundle install

# Copy the rest of the application code
COPY ./backend /backend

# Copy shell scripts and make them executable
COPY ./infrastructure/shell/backend/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/*

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
