#!/bin/bash



# Set up directories
INSTALL_DIR="$HOME/.download-tools"
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR" || exit

echo "Setting up global 'download' command..."

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is required but not installed. Please install Python 3 first."
    exit 1
fi

# Create virtual environment
echo "Creating Python virtual environment..."
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate

# Install yt-dlp
echo "Installing yt-dlp..."
pip install yt-dlp

# Copy the downloader script from the repo
cp "$(dirname "$0")/downloader.sh" "$INSTALL_DIR/downloader.sh"
chmod +x "$INSTALL_DIR/downloader.sh"

# Create the global command script that will be added to PATH
cat > download << 'EOF'
#!/bin/bash
"$HOME/.download-tools/downloader.sh" "$@"
EOF

chmod +x download

# Determine which shell the user is using
SHELL_NAME=$(basename "$SHELL")

# Create the necessary shell configuration
if [ "$SHELL_NAME" = "zsh" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ "$SHELL_NAME" = "bash" ]; then
    SHELL_CONFIG="$HOME/.bash_profile"
    if [ ! -f "$SHELL_CONFIG" ]; then
        SHELL_CONFIG="$HOME/.bashrc"
    fi
else
    echo "Unsupported shell: $SHELL_NAME. Please manually add $INSTALL_DIR to your PATH."
    exit 1
fi

# Check if the line is already in the shell config
if ! grep -q "# download command path" "$SHELL_CONFIG"; then
    # Add the download directory to PATH in the shell config
    echo "" >> "$SHELL_CONFIG"
    echo "# download command path" >> "$SHELL_CONFIG"
    echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$SHELL_CONFIG"
    echo "Added download command to your PATH in $SHELL_CONFIG"
else
    echo "download path already exists in $SHELL_CONFIG"
fi

echo ""
echo "======================================================================"
echo "Setup complete! Restart your terminal or run:"
echo "  source $SHELL_CONFIG"
echo ""
echo "Then you can download videos from anywhere using:"
echo "  download \"YOUR_YOUTUBE_URL\" quality"
echo ""
echo "Available quality options: best, 1080p, 720p, 480p, 360p, audio"
echo "All videos will be saved to: $HOME/Downloads/YouTube"
echo "======================================================================"