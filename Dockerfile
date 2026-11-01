version: '3.8'

services:
  maxs-menu:
    # Pulls and builds directly from the GitHub repository fork
    build: https://github.com/tubes41/maxs-menu
    container_name: maxs-menu-app
    network_mode: host
    environment:
      - SITE_NAME=${SITE_NAME}
      - TIMEZONE=${TIMEZONE}
      - ADMIN_USERNAME=${ADMIN_USERNAME}
      - ADMIN_PASSWORD=${ADMIN_PASSWORD}
      - MENU_PORT=${MENU_PORT}
    volumes:
      - /shared-config/maxs-menu/data:/data
    restart: unless-stopped
