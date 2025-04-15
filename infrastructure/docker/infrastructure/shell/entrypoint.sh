#!/bin/sh

# Set AWS Profile
/usr/bin/create_aws_profile.sh

# Set Shellscript
cp -a ./infrastructure/docker/infrastructure/shell/* /usr/bin/
chmod +x /usr/bin/*

# Keep the Container Running
tail -f /dev/null

exec "$@"
