# Akyemansa FM - HLS Streaming Proxy

This service converts the Shoutcast stream to HLS format for HTTPS compatibility.

## Railway Deployment

1. Push this directory to a GitHub repository
2. Create a new project on Railway
3. Connect your GitHub repo
4. Railway will automatically detect the Dockerfile and deploy

## Endpoints

- `/stream/live.m3u8` - HLS playlist
- `/health` - Health check

## Usage in App

```javascript
const STREAM_URL = "https://your-railway-url.railway.app/stream/live.m3u8";
audio.src = STREAM_URL;
```
