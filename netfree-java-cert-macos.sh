#!/bin/bash

echo "Essai de téléchargement du certificat NetFree"

# Télécharger le certificat
CERT_URL="http://netfree.link/netfree-ca.crt"
CERT=$(curl -L "$CERT_URL" 2>/dev/null)

if [[ $CERT == *"BEGIN CERTIFICATE"* ]]; then
    echo "Certificat téléchargé avec succès."

    # Recherche dans /Users/elie/Library/Java/JavaVirtualMachines/ des fichiers cacerts et importe le certificat
    find /Users/elie/Library/Java/JavaVirtualMachines/ -name cacerts -exec sh -c 'echo "'"$CERT"'" | keytool -import -trustcacerts -alias netfree-ca -keystore "{}" -storepass changeit -noprompt' \;

    echo "Certificat importé dans tous les keystores cacerts trouvés."
else
    echo "Erreur : Le certificat NetFree n'a pas pu être téléchargé ou est invalide."
fi
