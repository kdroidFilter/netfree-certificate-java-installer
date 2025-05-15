#!/bin/bash

# Script to download and install MyCA certificate
set -euo pipefail

CERT_URL="https://api-slave.netsparkmobile.com/support/myca.crt"
CERT_NAME="myca.crt"
CERT_DIR="/usr/local/share/ca-certificates/myca"

echo "Downloading certificate..."
TMP_CERT=$(mktemp)
trap 'rm -f "$TMP_CERT"' EXIT

curl -fsSL "$CERT_URL" -o "$TMP_CERT"

if ! grep -q "BEGIN CERTIFICATE" "$TMP_CERT"; then
    echo "Error: invalid certificate." >&2
    exit 1
fi

sudo install -d -m 0755 "$CERT_DIR"
sudo install -m 0644 "$TMP_CERT" "$CERT_DIR/$CERT_NAME"

echo "Updating CA certificate store..."
sudo update-ca-certificates > /dev/null

echo "Done."

