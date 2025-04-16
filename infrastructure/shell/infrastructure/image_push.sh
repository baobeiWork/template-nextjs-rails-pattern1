#!/bin/bash

# Check if required environment variables are set
if [ -z "$SYSTEM_NAME" ]; then
    echo "Error: SYSTEM_NAME is not set."
    exit 1
fi

if [ -z "$SYSTEM_ENV" ]; then
    echo "Error: SYSTEM_ENV is not set."
    exit 1
fi

if [ -z "$SYSTEM_DOMAIN" ]; then
    echo "Error: SYSTEM_DOMAIN is not set."
    exit 1
fi

if [ -z "$AWS_DEFAULT_REGION" ]; then
    echo "Error: AWS_DEFAULT_REGION is not set."
    exit 1
fi

#if [ -z "$MYSQL_ROOT_USER" ]; then
#    echo "Error: MYSQL_ROOT_USER is not set."
#    exit 1
#fi

#if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
#    echo "Error: MYSQL_ROOT_PASSWORD is not set."
#    exit 1
#fi

#if [ -z "$MYSQL_DATABASE" ]; then
#    echo "Error: MYSQL_DATABASE is not set."
#    exit 1
#fi

# Set required environment variables
## AWS
REPOSITORY_NAME="${SYSTEM_NAME}-${SYSTEM_ENV}-main-repo"
AWS_REGION=${AWS_DEFAULT_REGION}
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ECR_URI="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPOSITORY_NAME}"

## RAILS
# Load DB credentials from SSM Parameter Store
SSM_PREFIX="/${SYSTEM_NAME}/${SYSTEM_ENV}"

DATABASE_USER=$(aws ssm get-parameter     --name "${SSM_PREFIX}/db_user"     --with-decryption --query "Parameter.Value" --output text)
DATABASE_PASSWORD=$(aws ssm get-parameter --name "${SSM_PREFIX}/db_password" --with-decryption --query "Parameter.Value" --output text)
DATABASE_NAME=$(aws ssm get-parameter     --name "${SSM_PREFIX}/db_name"     --with-decryption --query "Parameter.Value" --output text)
DATABASE_HOST=$(aws ssm get-parameter     --name "${SSM_PREFIX}/db_host"     --with-decryption --query "Parameter.Value" --output text)

# （不要になった環境変数のチェックやセットは削除可）


# Log in to ECR
echo "Logging in to ECR..."
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_URI}

# Build Docker image
echo "Building Docker image..."
docker build --no-cache -t ${REPOSITORY_NAME} \
    --build-arg SYSTEM_NAME=${SYSTEM_NAME} \
    --build-arg SYSTEM_DOMAIN=${SYSTEM_DOMAIN} \
    --build-arg RAILS_ENV=${SYSTEM_ENV} \
    --build-arg DATABASE_USER=${DATABASE_USER} \
    --build-arg DATABASE_PASSWORD=${DATABASE_PASSWORD} \
    --build-arg DATABASE_NAME=${DATABASE_NAME} \
    --build-arg DATABASE_HOST=${DATABASE_HOST} \
     -f ./infrastructure/docker/backend/Dockerfile .

# Tag Docker image
echo "Tagging Docker image..."
docker tag ${REPOSITORY_NAME}:latest ${ECR_URI}:latest

# Push Docker image to ECR
echo "Pushing Docker image to ECR..."
if ! docker push ${ECR_URI}:latest; then
    echo "Error: Failed to push Docker image to ECR"
    exit 1
fi

echo "Docker image successfully pushed to ECR: ${ECR_URI}:latest"
