#!/bin/bash

# downloader.sh - Global YouTube video downloader
# Usage: download "URL" quality

# Activate the virtual environment
source "$HOME/.download-tools/venv/bin/activate"

# Check if a URL was provided
if [ -z "$1" ]; then
    echo "Please provide a YouTube URL in quotes"
    echo "Usage: download \"URL\" quality"
    echo "Available quality options: best, 1080p, 720p, 480p, 360p, audio"
    exit 1
fi

URL="$1"
QUALITY="${2:-best}"
DOWNLOAD_DIR="$HOME/Downloads/YouTube"

# Create download directory if it doesn't exist
mkdir -p "$DOWNLOAD_DIR"

# Function to download with progress
download_video() {
    local format="$1"
    echo "Downloading video in $QUALITY quality (MP4 format)..."
    
    # Add preference for mp4 format and merge into mp4 container
    yt-dlp -f "$format" \
        -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" \
        --concurrent-fragments 4 \
        --merge-output-format mp4 \
        --format-sort ext:mp4:m4a \
        "$URL"
}

# Download based on selected quality
case "$QUALITY" in
    "best")
        # Download best quality video with best audio
        download_video "bestvideo+bestaudio/best"
        ;;
    "1080p")
        # Download 1080p video with best audio
        download_video "bestvideo[height<=1080]+bestaudio/best[height<=1080]"
        ;;
    "720p")
        # Download 720p video with best audio
        download_video "bestvideo[height<=720]+bestaudio/best[height<=720]"
        ;;
    "480p")
        # Download 480p video with best audio
        download_video "bestvideo[height<=480]+bestaudio/best[height<=480]"
        ;;
    "360p")
        # Download 360p video with best audio
        download_video "bestvideo[height<=360]+bestaudio/best[height<=360]"
        ;;
    "audio")
        # Download audio only (highest quality)
        echo "Downloading audio only (MP3 format)..."
        yt-dlp -f "bestaudio" \
            --extract-audio \
            --audio-format mp3 \
            --audio-quality 0 \
            -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" \
            "$URL"
        ;;
    *)
        echo "Invalid quality option. Using best quality."
        download_video "bestvideo+bestaudio/best"
        ;;
esac

echo "Download complete! Video saved to $DOWNLOAD_DIR"
echo "Enjoy your video!"