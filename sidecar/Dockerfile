# sidecar/Dockerfile
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl \
    nvidia-driver-550 \
    nvidia-utils-550

RUN pip3 install flask requests pyjwt

COPY verify-attestation.sh /usr/local/bin/
COPY api.py /usr/local/bin/
COPY start.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/verify-attestation.sh \
    /usr/local/bin/api.py \
    /usr/local/bin/start.sh

EXPOSE 8080
CMD ["/usr/local/bin/start.sh"]