#!/bin/bash

echo "Try download NetFree certificate"

# Download certificate
CERT_URL="http://netfree.link/netfree-ca.crt"
CERT=$(curl -L "$CERT_URL" 2> /dev/null)

if [[ $CERT == *"BEGIN CERTIFICATE"* ]]; then
    # Create temp directory and save the certificate there
    temp_dir=$(mktemp -d)
    echo "$CERT" > "${temp_dir}/netfree-ca.crt"
    echo "Certificate downloaded and saved successfully."

    # Find all cacerts files, check if they are valid keystores, and import the certificate
    sudo find / -name cacerts -exec sh -c 'keytool -list -keystore "{}" -storepass changeit > /dev/null 2>&1 && keytool -import -trustcacerts -alias netfree-ca -file "'${temp_dir}'/netfree-ca.crt" -keystore "{}" -storepass changeit -noprompt' \;

    # Clean up: remove the temp directory
    rm -rf "${temp_dir}"
    echo "Certificate imported to all found cacerts keystores."
else
    echo "Error: NetFree certificate could not be downloaded or is invalid."
fi
