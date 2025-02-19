# sidecar/start.sh
#!/bin/bash
python3 /app/api.py &
/app/verify-attestation.sh