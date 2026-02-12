# Use Alpine Linux with FFmpeg pre-installed
FROM lscr.io/linuxserver/ffmpeg:latest

# Install nginx to serve the HLS files
RUN apk add --no-cache nginx

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
