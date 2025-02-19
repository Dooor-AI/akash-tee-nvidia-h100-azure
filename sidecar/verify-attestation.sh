# sidecar/verify-attestation.sh
#!/bin/bash
mkdir -p /certs
cd /certs

while true; do
    echo "Starting attestation cycle..."
    
    # Rodar attestation e capturar saída
    OUTPUT=$(sudo bash /app/step-2-attestation.sh)
    ATTESTATION_STATUS=$?
    
    # Criar JSON com resultado
    cat > status.json <<EOF
{
    "status": "$([ $ATTESTATION_STATUS -eq 0 ] && echo 'success' || echo 'failed')",
    "last_verification": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
    "output": "$OUTPUT"
}
EOF
    
    sleep 300
done