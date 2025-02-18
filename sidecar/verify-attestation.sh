# sidecar/verify-attestation.sh
#!/bin/bash
mkdir -p /certs
cd /certs

while true; do
    echo "Starting attestation cycle..."
    sudo bash ./step-2-attestation.sh > attestation_output.txt
    sleep 300
done