# sidecar/Dockerfile
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    sudo \
    wget

WORKDIR /app

# Download e extrair o pacote de onboarding
RUN wget https://github.com/Azure/az-cgpu-onboarding/releases/download/V3.2.2/cgpu-onboarding-package.tar.gz && \
    tar -xvf cgpu-onboarding-package.tar.gz && \
    mv cgpu-onboarding-package/* . && \
    rm -rf cgpu-onboarding-package cgpu-onboarding-package.tar.gz

# Copiar arquivos do sidecar
COPY api.py verify-attestation.sh start.sh ./

RUN chmod +x *.sh
RUN pip3 install flask requests

EXPOSE 8080
CMD ["./start.sh"]