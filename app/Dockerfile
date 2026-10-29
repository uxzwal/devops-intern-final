# syntax=docker/dockerfile:1

ARG BUILD_SHA=unknown

# Base image pinned to a specific version
FROM nginx:1.27-alpine

# Set build-time argument as environment variable
ENV BUILD_SHA=${BUILD_SHA}

# Copy custom configuration and static content
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/index.html

# Replace placeholder in index.html with the actual build SHA
RUN sed -i "s|BUILD_SHA|${BUILD_SHA}|g" /usr/share/nginx/html/index.html

# Expose the non‑standard HTTP port
EXPOSE 8080

# Healthcheck that hits the /healthz endpoint
HEALTHCHECK --interval=30s --timeout=5s \
  CMD curl -f http://localhost:8080/healthz || exit 1

# Run nginx as the default non‑root user (nginx) provided by the base image
USER nginx

CMD ["nginx", "-g", "daemon off;"]
