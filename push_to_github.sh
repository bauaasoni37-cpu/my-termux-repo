#!/data/data/com.termux/files/usr/bin/bash
set -e

# Make sure we are in the repository directory
REPO_DIR="/data/data/com.termux/files/home/my-custom-repo"
cd "$REPO_DIR"

if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
    git branch -M main
fi

GH_USER="bauaasoni37-cpu"
REPO_NAME="my-termux-repo"
REMOTE_URL="https://github.com/${GH_USER}/${REPO_NAME}.git"

# Set or update remote origin
if ! git remote | grep -q "^origin$"; then
    echo "Adding remote origin: $REMOTE_URL"
    git remote add origin "$REMOTE_URL"
else
    echo "Updating remote origin to: $REMOTE_URL"
    git remote set-url origin "$REMOTE_URL"
fi

echo "Staging files for commit..."
git add .

echo "Creating commit..."
git commit -m "Added build package (agent command) and install scripts" || echo "No changes to commit"

echo "Pushing to GitHub..."
git push -u origin main
