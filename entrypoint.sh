#!/usr/bin/env bash
set -e

export MENU_DATA_DIR="/data"
export SITE_NAME="${SITE_NAME:-Maxs Menu}"
export TIMEZONE="${TIMEZONE:-Australia/Perth}"
export ADMIN_USERNAME="${ADMIN_USERNAME:-admin}"
export ADMIN_PASSWORD="${ADMIN_PASSWORD:-password123}"
export MENU_PORT="${MENU_PORT:-8080}"

chown -R 1000:1000 /data

if [ ! -f "$MENU_DATA_DIR/users.json" ]; then
    echo "First boot detected. Initializing '$SITE_NAME' ($TIMEZONE) for user '$ADMIN_USERNAME'..."

    # setpriv fools configure.py into seeing a non-root User ID (1000)
    setpriv --reuid=1000 --regid=1000 --clear-groups python3 configure.py <<EOF
$SITE_NAME
$TIMEZONE
no
$ADMIN_USERNAME
$ADMIN_PASSWORD
$ADMIN_PASSWORD
EOF

else
    echo "Existing configuration found in $MENU_DATA_DIR/users.json. Skipping initialization."
fi

echo "Starting Max's Menu backend server on port $MENU_PORT..."
exec python3 app.py
