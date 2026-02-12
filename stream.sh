#!/bin/sh

# Start nginx in the background
nginx

# Start FFmpeg to convert Shoutcast stream to HLS
ffmpeg -i http://uk24freenew.listen2myradio.com:19279/ \
  -c:a aac \
  -b:a 128k \
  -f hls \
  -hls_time 6 \
  -hls_list_size 4 \
  -hls_flags delete_segments+append_list \
  -hls_segment_filename /var/www/html/stream/segment%d.ts \
  /var/www/html/stream/live.m3u8
