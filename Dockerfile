version: '3.8'

services:
  maxs-menu:
    # Pulls and builds directly from the GitHub repository fork
    build: https://github.com/tubes41/maxs-menu
    container_name: maxs-menu-app
    ports:
      - "8081:8080"
    environment:
      - SITE_NAME=${SITE_NAME}
      - TIMEZONE=${TIMEZONE}
      - ADMIN_USERNAME=${ADMIN_USERNAME}
      - ADMIN_PASSWORD=${ADMIN_PASSWORD}
    volumes:
      - /shared-config/maxs-menu/data:/data
    restart: unless-stopped
