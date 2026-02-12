# Use Alpine Linux with FFmpeg
FROM alpine:3.19

# Install FFmpeg and nginx
RUN apk add --no-cache \
    ffmpeg \
    nginx

# Create directories
RUN mkdir -p /var/www/html/stream /run/nginx

# Create nginx config inline
RUN echo 'worker_processes 1;\n\
events { worker_connections 1024; }\n\
http {\n\
    include /etc/nginx/mime.types;\n\
    default_type application/octet-stream;\n\
    server {\n\
        listen 8080;\n\
        add_header Access-Control-Allow-Origin * always;\n\
        add_header Access-Control-Allow-Methods "GET, OPTIONS" always;\n\
        location /stream/ {\n\
            alias /var/www/html/stream/;\n\
            add_header Cache-Control "no-cache";\n\
            types { application/vnd.apple.mpegurl m3u8; video/mp2t ts; }\n\
        }\n\
        location /health { return 200 "OK"; add_header Content-Type text/plain; }\n\
    }\n\
}' > /etc/nginx/nginx.conf

# Expose port
EXPOSE 8080

# Start nginx and ffmpeg directly
CMD nginx && \
    ffmpeg -loglevel info \
    -i http://uk24freenew.listen2myradio.com:19279/ \
    -c:a aac -b:a 128k -f hls \
    -hls_time 6 -hls_list_size 4 \
    -hls_flags delete_segments+append_list \
    -hls_segment_filename /var/www/html/stream/segment%d.ts \
    /var/www/html/stream/live.m3u8
