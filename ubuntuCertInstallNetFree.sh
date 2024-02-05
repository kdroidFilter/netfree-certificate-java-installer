#!/bin/bash


echo "Try download NetFree certificate"


CERT=$(curl -L "http://netfree.link/netfree-ca.crt" 2> /dev/null)

if [[ $CERT == *"BEGIN CERTIFICATE"* ]]
then
    sudo mkdir -p "/usr/share/ca-certificates/extra/"
    echo "$CERT" | sudo tee  "/usr/share/ca-certificates/extra/netfree-ca.crt" > /dev/null
    echo "save certificate"
    
    sudo dpkg-reconfigure -f noninteractive ca-certificates
    sudo sed -i.bak  s/\!extra\\/netfree-ca/extra\\/netfree-ca/g /etc/ca-certificates.conf
    sudo dpkg-reconfigure -f noninteractive ca-certificates
    
else
    echo "error: not have NetFree certificate"
fi
