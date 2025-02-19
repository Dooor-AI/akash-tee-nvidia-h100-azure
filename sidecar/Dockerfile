# sidecar/Dockerfile
FROM python:3.9-slim

WORKDIR /app
RUN apt-get update && apt-get install -y \
    python3-pip

RUN pip3 install flask requests pyjwt

COPY api.py /app/
COPY start.sh /app/

RUN chmod +x /app/start.sh

EXPOSE 8080
CMD ["/app/start.sh"]