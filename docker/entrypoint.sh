#!/bin/bash
set -e

echo 'Entry Point'
# Remove a potentially pre-existing server.pid for Rails.
rm -f /var/www/tmp/pids/server.pid

cron start

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
