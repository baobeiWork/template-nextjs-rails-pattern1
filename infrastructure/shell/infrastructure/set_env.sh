#!/bin/bash

VALID_ENVS=("production" "staging" "test")

function is_valid_env {
  for env in "${VALID_ENVS[@]}"; do
    if [ "$1" == "$env" ]; then
      return 0
    fi
  done
  return 1
}

if [ $# -eq 1 ]; then
  SYSTEM_ENV=$1
  if ! is_valid_env "$SYSTEM_ENV"; then
    echo "Invalid environment: $SYSTEM_ENV"
    SYSTEM_ENV=""
  fi
fi

while [ -z "$SYSTEM_ENV" ]; do
  read -p "Please enter the environment (production, staging, test): " SYSTEM_ENV
  if ! is_valid_env "$SYSTEM_ENV"; then
    echo "Invalid environment. Please enter 'production', 'staging', or 'test'."
    SYSTEM_ENV=""
  fi
done

# Common
export SYSTEM_ENV=$SYSTEM_ENV
export BUCKET_NAME="${SYSTEM_NAME}-${SYSTEM_ENV}-tfstate-bucket"
export LOCK_TABLE="${SYSTEM_NAME}-${SYSTEM_ENV}-table"

## Terraform
export TF_VAR_SYSTEM_ENV=$SYSTEM_ENV
export TF_VAR_SYSTEM_NAME=$SYSTEM_NAME
export TF_VAR_AWS_ACCESS_KEY=$AWS_ACCESS_KEY
export TF_VAR_AWS_SECRET_KEY=$AWS_SECRET_ACCESS_KEY

## Cloud Formation 
export STACK_NAME="${SYSTEM_NAME}-${SYSTEM_ENV}-preparation"
export STACK_TEMPLATE="file://./preparation.yml"

# Display
echo "SYSTEM_ENV: $SYSTEM_ENV"
echo "BUCKET_NAME: $BUCKET_NAME"
echo "LOCK_TABLE: $LOCK_TABLE"
echo "STACK_NAME: $STACK_NAME"
echo "STACK_TEMPLATE: $STACK_TEMPLATE"
echo "AWS_ACCESS_KEY: $AWS_ACCESS_KEY"
echo "AWS_SECRET_ACCESS_KEY: $AWS_SECRET_ACCESS_KEY"
ehco 
echo "TF_VAR_SYSTEM_ENV: $TF_VAR_SYSTEM_ENV"
echo "TF_VAR_SYSTEM_NAME: $TF_VAR_SYSTEM_NAME"
echo "TF_VAR_SYSTEM_AZ: $TF_VAR_SYSTEM_AZ"
echo "TF_VAR_AWS_ACCESS_KEY: $TF_VAR_AWS_ACCESS_KEY"
echo "TF_VAR_AWS_SECRET_KEY: $TF_VAR_AWS_SECRET_KEY"
