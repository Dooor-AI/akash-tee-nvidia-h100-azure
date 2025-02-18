# sidecar/start.sh
#!/bin/bash
python3 /usr/local/bin/api.py &
/usr/local/bin/verify-attestation.sh
