#!/bin/bash

# Start the first process
# cp /home/node/app/ssl/auth/auth.pem /home/node/app/auth.pem;
# cp /home/node/app/ssl/avisoDeVenta/avisoDeVenta.pem /home/node/app/avisoDeVenta.pem;

# envsubst < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf

echo "hello"
pwd
mkdir certs
# cd certs
printenv CA_CERT_TEXT > /certs/ca.crt
printenv SERVER_KEY_TEXT > /certs/server.key
printenv SERVER_CERT_TEXT > /certs/server.crt
printenv PASSPHRASE_SERVER_TEXT > /certs/passphrase.server.txt

printenv CLIENT_KEY_TEXT > /certs/client.key
printenv CLIENT_CERT_TEXT > /certs/client.crt
printenv PASSPHRASE_CLIENT_TEXT > /certs/passphrase.client.txt

cd ..


nginx -g "daemon off;" &
  
# Start the second process
cd /home/node/app/dist &&  npm run start:pm2
  
# Wait for any process to exit
# wait -n
  
# Exit with status of process that exited first
# exit $?