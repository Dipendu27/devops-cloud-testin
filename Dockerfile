# Base image — lightweight Linux
FROM alpine:3.19

# Who built this
LABEL maintainer="Dipendu Mukherjee"
LABEL project="devops-cloud-testing"

# Install runtime tools for monitoring and JSON validation
RUN apk add --no-cache curl bash jq

# Create working directory inside container
WORKDIR /app

# Copy monitor and inventory validation files into the container
COPY ubuy_monitor.sh .
COPY inventory_check.sh .
COPY ubuy_inventory.json .

# Make both scripts executable
RUN chmod +x ubuy_monitor.sh inventory_check.sh

# Default command (runs the monitor if no other command is given)
CMD ["bash", "ubuy_monitor.sh"]
