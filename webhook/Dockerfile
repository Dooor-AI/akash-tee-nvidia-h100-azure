# webhook/Dockerfile
FROM python:3.11-slim-bookworm
RUN apt-get update && apt-get install -y bash sudo
WORKDIR /app
COPY webhook.py /app/
RUN pip install flask requests
CMD ["python", "webhook.py"]
