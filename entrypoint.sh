#!/bin/sh

# Exit on fail
set -e

# If running the Rails server then create or migrate existing database
if [ "$1" = "bundle" ] && [ "$2" = "exec" ] && [ "$3" = "rails" ] && [ "$4" = "s" ]; then
  bin/rails db:prepare
fi

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Start Tailwind CSS watcher in the background
bin/rails tailwindcss:watch &

rake assets:precompile

# Execute the given command
exec "$@"
