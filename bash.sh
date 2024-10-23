#!/bin/bash

# Start the first process
# cp /home/node/app/ssl/auth/auth.pem /home/node/app/auth.pem;
# cp /home/node/app/ssl/avisoDeVenta/avisoDeVenta.pem /home/node/app/avisoDeVenta.pem;


nginx -g "daemon off;" &
  
# Start the second process
cd /home/node/app/dist &&  npm run start:pm2
  
# Wait for any process to exit
# wait -n
  
# Exit with status of process that exited first
# exit $?