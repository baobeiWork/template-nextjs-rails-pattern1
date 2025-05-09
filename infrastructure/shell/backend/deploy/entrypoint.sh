#!/bin/sh
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /${SYSTEM_NAME}/tmp/pids/server.pid

# Set the Rails environment variable
export RAILS_ENV=${RAILS_ENV:-development}

# Update bundle
bundle install

# Check if the database exists and create it if it doesn't
if ! bundle exec rails db:create; then
  echo "Database does not exist. Creating database..."
  bundle exec rails db:create
fi

# Apply Ridgepole migrations only if Schemafile exists
if [ -f "db/schemas/Schemafile" ]; then
  echo "Applying schema with Ridgepole..."
  bundle exec ridgepole -c config/database.yml --env $RAILS_ENV --apply -f db/schemas/Schemafile
else
  echo "Schemafile not found. Skipping Ridgepole migration."
fi

# Apply Seed File 
# bundle exec rails db:seed

# Start the application
exec rails server -b 0.0.0.0
