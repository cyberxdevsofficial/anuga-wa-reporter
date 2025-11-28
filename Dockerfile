FROM ubuntu:24.04

# Install minimal dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      bash coreutils wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copy app
WORKDIR /app
COPY app.sh /app/app.sh
RUN chmod +x /app/app.sh

ENTRYPOINT ["/app/app.sh"]
