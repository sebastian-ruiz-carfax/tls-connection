#!/bin/bash

# Variables
URL="https://localhost:443/health"
CERT_FILE="./certs/client.crt"
KEY_FILE="./certs/client.key"
CA_CERT_FILE="./certs/ca.crt"
PASSPHRASE=$(cat ./certs/passphrase.client.txt)

# Make the HTTPS request with client certificates get http headers, but only the line of the status code
HTTP_LINE=$(curl -k -s -i --cert $CERT_FILE --key $KEY_FILE --cacert $CA_CERT_FILE --pass "$PASSPHRASE" $URL | grep -i "HTTP/1.1")

echo $HTTP_LINE
# Extract the status code from the HTTP line
STATUS_CODE=$(echo "$HTTP_LINE" | awk '{print $2}')

echo $STATUS_CODE

if [ $STATUS_CODE = "200" ]; then
  echo "The response contains 200."
  exit 0
else
  echo "The response does not contain 200."
  exit 1
fi

exit 1