#!/bin/sh

# Install Package
yarn install

# Start the application
if [ "$NEXT_ENV" = "development" ]; then
  echo "Environment is development, starting yarn dev..."
  yarn dev 
elif [ "$NEXT_ENV" = "staging" ]; then
  echo "Environment is stg, starting yarn stg..."
  yarn stg 
elif [ "$NEXT_ENV" = "production" ]; then
  echo "Environment is prodcution, starting build and start..."
  yarn build 
  yarn start
else
  echo "Please specify the environment..."
fi
