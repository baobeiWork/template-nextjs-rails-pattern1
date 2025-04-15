#!/bin/sh
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /${SYSTEM_NAME}/tmp/pids/server.pid

# Set the Rails environment variable
export RAILS_ENV=${RAILS_ENV:-development}

# Check if the database exists and create it if it doesn't
if ! bundle exec rails db:create; then
  echo "Database does not exist. Creating database..."
  bundle exec rails db:create
fi

# Apply Ridgepole migrations
bundle exec ridgepole -c config/database.yml --env $RAILS_ENV --apply -f db/schemas/Schemafile

# Apply Seed File 
# bundle exec rails db:seed

# Start the application
exec rails server -b 0.0.0.0
