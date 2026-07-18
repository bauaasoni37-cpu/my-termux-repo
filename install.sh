#!/data/data/com.termux/files/usr/bin/bash
set -e

# Repository configuration
GH_USER="bauaasoni37-cpu"
REPO_NAME="my-termux-repo"

echo -e "\e[1;32m[*] Adding $REPO_NAME to Termux package sources...\e[0m"

# Ensure the directory exists
mkdir -p "$PREFIX/etc/apt/sources.list.d"

# Create the sources.list.d file
echo "deb [trusted=yes arch=all] https://${GH_USER}.github.io/${REPO_NAME}/ termux extras" > "$PREFIX/etc/apt/sources.list.d/myrepo.list"

# Add dependent termuxvoid repository for android-sdk and flutter packages
if [ ! -f "$PREFIX/etc/apt/sources.list.d/termuxvoid.list" ] && ! grep -q "termuxvoid" "$PREFIX/etc/apt/sources.list" "$PREFIX/etc/apt/sources.list.d/"* 2>/dev/null; then
    echo -e "\e[1;32m[*] Adding dependent repository (termuxvoid)...\e[0m"
    echo "deb [trusted=yes arch=all] https://termuxvoid.github.io/repo termuxvoid main" > "$PREFIX/etc/apt/sources.list.d/termuxvoid.list"
fi

echo -e "\e[1;32m[*] Updating package index...\e[0m"
apt-get update -y

echo -e "\e[1;32m[+] Successfully added repository! You can now run 'pkg install <package_name>'.\e[0m"
