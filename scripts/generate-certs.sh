# scripts/generate-certs.sh

#!/bin/bash
set -e

# Create necessary directories
mkdir -p certs

# Generate CA key and certificate
openssl genrsa -out certs/ca.key 2048
openssl req -x509 -new -nodes -key certs/ca.key -days 365 -out certs/ca.crt -subj "/CN=gpu-webhook-ca"

# Generate server key and CSR
openssl genrsa -out certs/tls.key 2048
openssl req -new -key certs/tls.key -out certs/server.csr -subj "/CN=gpu-webhook.kube-system.svc" \
    -config <(cat <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = gpu-webhook
DNS.2 = gpu-webhook.kube-system
DNS.3 = gpu-webhook.kube-system.svc
EOF
    )

# Sign the server certificate
openssl x509 -req -in certs/server.csr -CA certs/ca.crt -CAkey certs/ca.key \
    -CAcreateserial -out certs/tls.crt -days 365 \
    -extensions v3_req \
    -extfile <(cat <<EOF
[v3_req]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = gpu-webhook
DNS.2 = gpu-webhook.kube-system
DNS.3 = gpu-webhook.kube-system.svc
EOF
    )

# Clean up temporary files
rm certs/server.csr certs/ca.key certs/ca.srl

echo "Certificates generated successfully in certs/ directory"