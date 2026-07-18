#!/data/data/com.termux/files/usr/bin/bash
set -e

# Repository configuration
GH_USER="bauaasoni37-cpu"
REPO_NAME="my-termux-repo"

echo -e "\e[1;32m[*] Adding $REPO_NAME to Termux package sources...\e[0m"

# Create the sources.list.d file
echo "deb [trusted=yes] https://${GH_USER}.github.io/${REPO_NAME}/termux/ termux extras" > "$PREFIX/etc/apt/sources.list.d/myrepo.list"

echo -e "\e[1;32m[*] Updating package index...\e[0m"
apt-get update -y

echo -e "\e[1;32m[+] Successfully added repository! You can now run 'pkg install <package_name>'.\e[0m"
