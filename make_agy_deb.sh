#!/data/data/com.termux/files/usr/bin/bash
set -e

# Make sure we are in the repository directory
REPO_DIR="/data/data/com.termux/files/home/my-custom-repo"
cd "$REPO_DIR"

echo "Creating temporary directory structure for agy deb package..."
TEMP_BUILD_DIR="agy-pkg-temp"
rm -rf "$TEMP_BUILD_DIR"
mkdir -p "$TEMP_BUILD_DIR/DEBIAN"

chmod 755 "$TEMP_BUILD_DIR"
chmod 755 "$TEMP_BUILD_DIR/DEBIAN"

# 1. Create control file
cat << 'EOF' > "$TEMP_BUILD_DIR/DEBIAN/control"
Package: agy
Version: 1.0.0
Architecture: all
Maintainer: bauaasoni37-cpu <bauaasoni37-cpu@users.noreply.github.com>
Depends: antigravity-cli
Description: Pre-configures Google Antigravity CLI and sets up the allowed commands list in the .gemini folder.
EOF

# 2. Create post-install script to configure the .gemini directory
cat << 'EOF' > "$TEMP_BUILD_DIR/DEBIAN/postinst"
#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "Running post-install configuration for agy package..."

# Change working directory to HOME to prevent any path issues
cd /data/data/com.termux/files/home || cd "$HOME" || true

# Set up .gemini directories
mkdir -p "/data/data/com.termux/files/home/.gemini/config"
mkdir -p "/data/data/com.termux/files/home/.gemini/antigravity-cli"

# Create config.json
cat << 'SUBEOF' > "/data/data/com.termux/files/home/.gemini/config/config.json"
{
  "userSettings": {
    "remoteControlHostname": "localhost-spectral-luna"
  }
}
SUBEOF

# Create settings.json with pre-approved commands for a seamless coding experience
cat << 'SUBEOF' > "/data/data/com.termux/files/home/.gemini/antigravity-cli/settings.json"
{
  "allowNonWorkspaceAccess": true,
  "permissions": {
    "allow": [
      "command(pkg)",
      "command(apt search)",
      "command(apt list)",
      "command(apt show)",
      "command(dpkg)",
      "command(find)",
      "command(java)",
      "command(mkdir)",
      "command(ln)",
      "command(flutter)",
      "command(echo)",
      "command(ls)",
      "command(yes)",
      "command(apt-get update)",
      "command(apt-get dist-upgrade)",
      "command(curl --version)",
      "command(git init)",
      "command(git config)",
      "command(git add)",
      "command(git commit)",
      "command(tail)",
      "command(cd)",
      "command(agent)",
      "command(cp)",
      "command(ps)",
      "command(grep)",
      "command(which)",
      "command(aapt2)",
      "command(./gradlew)",
      "command(basename)",
      "command(sed)",
      "command(cat)"
    ]
  },
  "trustedWorkspaces": [
    "/data/data/com.termux/files/home"
  ]
}
SUBEOF

# Fix permissions
chown -R $(whoami):$(whoami) "/data/data/com.termux/files/home/.gemini" 2>/dev/null || true

echo "Google Antigravity CLI configuration set up successfully."
exit 0
EOF
chmod 755 "$TEMP_BUILD_DIR/DEBIAN/postinst"

# 3. Build the .deb package
echo "Building the agy debian package..."
dpkg-deb --build "$TEMP_BUILD_DIR" debs/agy_1.0.0_all.deb

# 4. Clean up temp folder
rm -rf "$TEMP_BUILD_DIR"

echo "Success! Package 'agy_1.0.0_all.deb' created in 'debs/' folder."
