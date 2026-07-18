#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_DIR="/data/data/com.termux/files/home/my-custom-repo"
cd "$REPO_DIR"

echo "Generating/Updating the Termux APT Repository structure..."
termux-apt-repo debs/ docs/

echo "Repository update complete!"
echo "Your repository files are now in the 'docs/' directory."
