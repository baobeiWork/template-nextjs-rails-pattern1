#!/bin/sh

mkdir -p ~/.aws

cat <<EOF > ~/.aws/credentials
[default]
aws_access_key_id=${AWS_ACCESS_KEY}
aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}
EOF

cat <<EOF > ~/.aws/config
[default]
region=${AWS_DEFAULT_REGION}
output=json
EOF

exec "$@"
