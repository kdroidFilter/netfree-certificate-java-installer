#!/bin/bash

# Script to download and install MyCA certificate

CERT_URL="https://api-slave.netsparkmobile.com/support/myca.crt"
CERT_NAME="myca.crt"
CERT_DIR="/usr/share/ca-certificates/extra"

echo "Downloading certificate from $CERT_URL..."
CERT=$(curl -L "$CERT_URL" 2> /dev/null)

if [[ $CERT == *"BEGIN CERTIFICATE"* ]]; then
    echo "Certificate downloaded successfully."
    sudo mkdir -p "$CERT_DIR"
    echo "$CERT" | sudo tee "$CERT_DIR/$CERT_NAME" > /dev/null
    echo "Saved certificate to $CERT_DIR/$CERT_NAME"

    echo "Configuring CA certificates..."
    sudo dpkg-reconfigure -f noninteractive ca-certificates
    sudo sed -i.bak "s|!extra\\/$CERT_NAME|extra\\/$CERT_NAME|g" /etc/ca-certificates.conf
    sudo dpkg-reconfigure -f noninteractive ca-certificates
    echo "Certificate installation complete."
else
    echo "Error: Failed to download a valid certificate."
    exit 1
fi
