#!/usr/bin/env bash
set -e

export MENU_DATA_DIR="/data"

# Clean strings with no internal backslashes or parsing pitfalls
SITE_NAME="${SITE_NAME:-Max\'s Menu}"
TIMEZONE="${TIMEZONE:-Australia/Perth}"
ADMIN_USERNAME="${ADMIN_USERNAME:-admin}"
ADMIN_PASSWORD="${ADMIN_PASSWORD:-password123}"
MENU_PORT="${MENU_PORT:-8080}"

chown -R 1000:1000 /data

if [ ! -f ".menu.env" ]; then
    echo "MENU_PORT=$MENU_PORT" > .menu.env
    chmod 600 .menu.env
fi

if [ ! -f "$MENU_DATA_DIR/users.json" ]; then
    echo "First boot detected. Running initialization wizard..."

    # setpriv fools configure.py into seeing a non-root User ID (1000)
    setpriv --reuid=1000 --regid=1000 --clear-groups python3 configure.py <<-EOF
$SITE_NAME
$TIMEZONE
no
$ADMIN_USERNAME
$ADMIN_PASSWORD
$ADMIN_PASSWORD
EOF

else
    echo "Existing configuration found in volume. Skipping initialization."
fi

echo "Starting Max\'s Menu backend server..."
exec python3 app.py
