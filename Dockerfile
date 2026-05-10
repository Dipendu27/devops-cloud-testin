# Base image — lightweight Linux with bash and curl built in
FROM alpine:3.19

# Who built this (shows up in docker inspect)
LABEL maintainer="Dipendu Mukherjee"
LABEL project="devops-cloud-testing"

# Install curl (alpine uses apk, not apt)
RUN apk add --no-cache curl bash

# Create working directory inside container
WORKDIR /app

# Copy your script into the container
COPY ubuy_monitor.sh .

# Make it executable
RUN chmod +x ubuy_monitor.sh

# Default command when container runs
CMD ["bash", "ubuy_monitor.sh"]