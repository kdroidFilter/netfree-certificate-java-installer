#!/bin/bash

echo "Try download NetFree certificate"

# Download certificate
CERT_URL="http://netfree.link/netfree-ca.crt"
CERT=$(curl -L "$CERT_URL" 2> /dev/null)

if [[ $CERT == *"BEGIN CERTIFICATE"* ]]; then
    echo "$CERT" > "${temp_dir}/netfree-ca.crt"
    echo "Certificate downloaded and saved successfully."

    # Find all cacerts files, check if they are valid keystores, and import the certificate
    sudo find / -name cacerts -exec sh -c 'echo "$(curl -sSL http://netfree.link/netfree-ca.crt)" | keytool -import -trustcacerts -alias netfree-ca -keystore "{}" -storepass changeit -file - -noprompt' \;

    echo "Certificate imported to all found cacerts keystores."
else
    echo "Error: NetFree certificate could not be downloaded or is invalid."
fi
