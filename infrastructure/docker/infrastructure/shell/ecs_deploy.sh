#!/bin/bash

set -e

# 必要な変数をチェック
: "${SYSTEM_NAME:?SYSTEM_NAME is not set}"
: "${SYSTEM_ENV:?SYSTEM_ENV is not set}"
: "${AWS_DEFAULT_REGION:?AWS_DEFAULT_REGION is not set}"

CLUSTER_NAME="${SYSTEM_NAME}-${SYSTEM_ENV}-main-cluster"
SERVICE_NAME="${SYSTEM_NAME}-${SYSTEM_ENV}-service"
TASK_FAMILY="${SYSTEM_NAME}-${SYSTEM_ENV}-backend-task"

echo "Fetching current task definition for family: $TASK_FAMILY"

# 現在の task definition を取得
CURRENT_TASK_DEF=$(aws ecs describe-task-definition \
  --task-definition "$TASK_FAMILY" \
  --query 'taskDefinition')

# 新しいタスク定義を登録（コンテナイメージだけ更新も可能）
echo "Registering new task definition..."
NEW_TASK_DEF=$(echo "$CURRENT_TASK_DEF" | jq ' 
  del(
    .taskDefinitionArn, 
    .revision, 
    .status, 
    .requiresAttributes, 
    .compatibilities, 
    .registeredAt, 
    .registeredBy 
  )')

NEW_TASK_DEF=$(echo "$NEW_TASK_DEF" | jq '.containerDefinitions[0].image |= sub(":.*$"; ":latest")')

# 新しいタスク定義を登録
NEW_REVISION=$(aws ecs register-task-definition \
  --cli-input-json "$NEW_TASK_DEF" \
  --query 'taskDefinition.revision' --output text)

echo "New task definition revision: $NEW_REVISION"

# ECS サービスを更新（force new deployment）
echo "Updating ECS service..."
aws ecs update-service \
  --cluster "$CLUSTER_NAME" \
  --service "$SERVICE_NAME" \
  --task-definition "$TASK_FAMILY:$NEW_REVISION" \
  --force-new-deployment

echo "ECS service updated with new task definition!"
