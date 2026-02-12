# Use Alpine Linux with FFmpeg
FROM alpine:3.19

# Install FFmpeg and nginx
RUN apk add --no-cache \
    ffmpeg \
    nginx

# Create directories
RUN mkdir -p /var/www/html/stream /run/nginx

# Copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port
EXPOSE 8080

# Start nginx and ffmpeg
CMD nginx && \
    ffmpeg -loglevel info \
    -i http://uk24freenew.listen2myradio.com:19279/ \
    -c:a aac -b:a 128k -f hls \
    -hls_time 6 -hls_list_size 4 \
    -hls_flags delete_segments+append_list \
    -hls_segment_filename /var/www/html/stream/segment%d.ts \
    /var/www/html/stream/live.m3u8
