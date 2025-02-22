# YouTube Downloader

A simple command-line tool to download YouTube videos in MP4 format on macOS. Built on top of the powerful yt-dlp library.

## Demo

[![YouTube Downloader Demo](https://img.youtube.com/vi/-61HvJnUu4I/0.jpg)](https://www.youtube.com/watch?v=-61HvJnUu4I)

*Click the image above to watch the demo video*

## Features

- Easy global command: `download "URL" quality`
- Downloads in MP4 format
- Multiple quality options
- Audio-only mode (MP3)

## Installation

```bash
git clone https://github.com/yourusername/youtube-downloader.git
cd youtube-downloader
chmod +x install.sh
./install.sh
```

## Usage

```bash
# Download in best quality
download "https://www.youtube.com/watch?v=dQw4w9WgXcQ" best

# Download in 720p
download "https://www.youtube.com/watch?v=dQw4w9WgXcQ" 720p

# Download audio only (MP3)
download "https://www.youtube.com/watch?v=dQw4w9WgXcQ" audio
```

## Quality Options

- `best` - Best available quality
- `1080p` - 1080p resolution
- `720p` - 720p resolution
- `480p` - 480p resolution
- `360p` - 360p resolution
- `audio` - Audio only (MP3)

## Requirements

- Python 3
- macOS (tested on macOS)
- Uses yt-dlp (automatically installed)

## License

MIT