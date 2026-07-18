#!/data/data/com.termux/files/usr/bin/bash
set -e

# Make sure we are in the repository directory
REPO_DIR="/data/data/com.termux/files/home/my-custom-repo"
mkdir -p "$REPO_DIR/debs"
cd "$REPO_DIR"

echo "Creating temp files for hello-custom deb package..."
TEMP_BUILD_DIR="hello-custom-temp"
mkdir -p "$TEMP_BUILD_DIR/DEBIAN"
chmod 755 "$TEMP_BUILD_DIR/DEBIAN"
mkdir -p "$TEMP_BUILD_DIR/data/data/com.termux/files/usr/bin"

# 1. Create control file
cat << 'EOF' > "$TEMP_BUILD_DIR/DEBIAN/control"
Package: hello-custom
Version: 1.0.0
Architecture: all
Maintainer: Termux User <user@termux.org>
Description: A simple hello script to test our custom apt repository.
EOF

# 2. Create the executable script that will be installed
cat << 'EOF' > "$TEMP_BUILD_DIR/data/data/com.termux/files/usr/bin/hello-custom"
#!/data/data/com.termux/files/usr/bin/bash
echo "Hello! This package was installed from your custom Termux repository!"
EOF
chmod +x "$TEMP_BUILD_DIR/data/data/com.termux/files/usr/bin/hello-custom"

# 3. Build the .deb package
echo "Building the debian package using dpkg-deb..."
dpkg-deb --build "$TEMP_BUILD_DIR" debs/hello-custom_1.0.0_all.deb

# 4. Clean up temp folder
rm -rf "$TEMP_BUILD_DIR"

echo "Success! Package 'hello-custom_1.0.0_all.deb' created in 'debs/' folder."
