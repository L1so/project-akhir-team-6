#!/bin/sh

# Abort on any error (including if wait-for-it fails).
set -e

# Wait for the backend to be up, if we know where it is.
if [ -n "$WAITHOST" ]; then
  /usr/src/app/wait.sh "$WAITHOST:${WAITPORT:-3306}"
fi

# Run the main container command.
exec "$@"
