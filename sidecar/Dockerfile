FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y curl openssl python3 python3-pip

COPY snpguest /usr/local/bin/snpguest
RUN chmod +x /usr/local/bin/snpguest

RUN pip3 install flask requests

COPY verify-attestation.sh /usr/local/bin/
COPY api.py /usr/local/bin/
COPY start.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/verify-attestation.sh \
    /usr/local/bin/api.py \
    /usr/local/bin/start.sh

EXPOSE 8080
CMD ["/usr/local/bin/start.sh"]