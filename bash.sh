rm -rf certs

mkdir certs

cd certs


## CERTIFICATE AUTHORITY
# Step 1: Generate a private key for the CA
openssl genrsa -out ca.key 4096

# Step 2: Create a self-signed root certificate
openssl req -x509 -new -nodes -key ca.key -sha256 -days 3650 -out ca.crt -subj '/CN=CARFAXMX/O=CARFAX MEXICO SA DE CV./C=MX'

## SERVER
# Step 1: Generate a private key for the server
openssl genrsa -out server.key 4096

# Step 2: Create a certificate signing request (CSR) for the server
openssl req -new -nodes -key server.key -out server.csr -subj '/CN=localhost/O=My Company Name LTD./C=US'

# Step 3: Sign the server CSR with the CA certificate and key to create the server certificate
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 365 -sha256 


## CLIENT
# Step 1: Generate a private key for the client
openssl genrsa -out client.key 4096

# Step 2: Create a certificate signing request (CSR) for the client
openssl req -new -nodes -key client.key -out client.csr -subj '/CN=localhost/O=My Company Name LTD./C=US'

# Step 3: Sign the client CSR with the CA certificate and key to create the client certificate
openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -days 365 -sha256 