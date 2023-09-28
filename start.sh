#!/bin/sh

/app/tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
/app/tailscale up --authkey=${TAILSCALE_AUTHKEY} --hostname=monica

cleanup() {
    echo "Received SIGINT. Cleaning up..."
    /app/tailscale logout
    kill $apache_pid
    exit
}

trap cleanup INT TERM

/usr/local/bin/entrypoint.sh apache2-foreground &
apache_pid=$!
wait $apache_pid
