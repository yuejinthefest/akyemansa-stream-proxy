# Use Alpine Linux with FFmpeg
FROM alpine:3.19

# Install FFmpeg and nginx
RUN apk add --no-cache \
    ffmpeg \
    nginx \
    bash

# Create directories for HLS output
RUN mkdir -p /var/www/html/stream /run/nginx

# Copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the streaming script
COPY stream.sh /stream.sh
RUN chmod +x /stream.sh

# Expose port for nginx
EXPOSE 8080

# Start script
CMD ["/stream.sh"]
