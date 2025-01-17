# Use the official slim version of Debian as the base image
FROM debian:bookworm-slim

# Metadata for traceability
LABEL maintainer="goran.angelkovski@gmail.com" \
      org.opencontainers.image.title="Base Debian Image" \
      org.opencontainers.image.description="A lightweight, secure, and optimized Debian base image." \
      org.opencontainers.image.version="1.0.0" \
      org.opencontainers.image.licenses="MIT"

# Set environment variables for non-interactive installs and minimize image size
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Define default build argument for username (if not provided "user" will be used)
ARG APP_USER=user

# Update package manager and install essential packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    wget \
    gnupg \
    software-properties-common \
    locales && \
    # Generate minimal locales
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen && \
    # Clean up to minimize image size
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add a non-root user using the build argument
RUN useradd --create-home --shell /bin/bash ${APP_USER} && \
    mkdir -p /home/${APP_USER} && \
    chown -R ${APP_USER}:${APP_USER} /home/${APP_USER}

# Switch to the non-root user
USER ${APP_USER}

# Working directory
WORKDIR /home/${APP_USER}

# Health check (example, override as needed)
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Default entrypoint and CMD
ENTRYPOINT ["/bin/bash"]
CMD ["bash"]
