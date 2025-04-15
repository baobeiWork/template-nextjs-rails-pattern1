#!/bin/sh

# Install Package
yarn install

# Start the application
if [ "$NUXT_ENV" = "development" ]; then
  echo "Environment is development, starting yarn dev..."
  yarn dev 
else
  echo "Environment is not development, starting yarn..."
  yarn
fi
