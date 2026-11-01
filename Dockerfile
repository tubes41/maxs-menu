FROM python:3.12-slim-trixie
WORKDIR /app

# Install standard dependencies
RUN apt-get update && apt-get install -y --no-install-recommends unzip && rm -rf /var/lib/apt/lists/*

# Install python requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all application assets and core code
COPY . .
RUN chmod +x entrypoint.sh

RUN mkdir -p /data
EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]
