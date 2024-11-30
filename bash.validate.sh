#!/bin/bash


# Get the expiration date of an SSL certificate
# EXPIRATION_DATE=$(echo | openssl x509 -noout -dates -in certsConPass/server.crt | grep 'notAfter' | cut -d= -f2)
EXPIRATION_DATE=$(echo | openssl x509 -noout -enddate -in certs/server.crt  | cut -d= -f2)


echo $EXPIRATION_DATE

# Convert the expiration date to seconds since epoch
EXPIRATION_DATE_SECONDS=$(date -d "$EXPIRATION_DATE" +%s)
CURRENT_DATE_SECONDS=$(date +%s)
CURRENT_DATE_IN_ONE_HOUR=$(date -d '+1 hour' +%s)


# # Check if the certificate is expired
if [ $CURRENT_DATE_IN_ONE_HOUR -ge $EXPIRATION_DATE_SECONDS ]; then
    echo "The SSL certificate for server is expired or about to expired within next hour."
else
    echo "The SSL certificate for client is valid."
fi
