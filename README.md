# my-termux-repo
A custom APT package repository for Termux.

This repository hosts custom-built Termux packages, including the fully automated **Android Build Environment** (`build` package) which sets up everything required to build Android APKs natively on device.

---

## 🚀 Quick Setup & Installation

You can add this repository to your Termux environment with a single command:

```bash
curl -sL https://raw.githubusercontent.com/bauaasoni37-cpu/my-termux-repo/main/install.sh | bash
```

This script will:
1. Create a sources list file in Termux:
   ```bash
   echo "deb [trusted=yes arch=all] https://bauaasoni37-cpu.github.io/my-termux-repo/ termux extras" > $PREFIX/etc/apt/sources.list.d/myrepo.list
   ```
2. Update the package index automatically.

---

## 📦 Available Packages

### 1. `build`
Automated development environment that installs and configures SDKs/NDKs natively in Termux.
* **Includes Command:** `agent` (e.g., `agent build apk` to automatically build Expo, Flutter, React Native, or Kotlin projects).
* **Dependencies Installed:**
  * Flutter SDK
  * Android SDK
  * Node.js (LTS) & Yarn
  * Java JDK 17 & 21
  * CMake, Make, Clang & Ninja
  * AAPT2, Apksigner, and Git
* **Auto-configurations:**
  * Sets up environment variables in `~/.bashrc` and `~/.zshrc`.
  * Overrides Maven AAPT2 to run natively (fixing common architecture incompatibility errors).
  * Auto-accepts SDK licenses.
  * Generates a debug keystore for app signing.

To install:
```bash
pkg install build
```

### 2. `hello-custom`
A simple shell script package to verify that the custom repository is working.
To install and run:
```bash
pkg install hello-custom
hello-custom
```

---

## 🛠️ How to Add Your Own Packages (For Owner)

1. Put your compiled `.deb` package files inside the `debs/` directory.
2. Run the update script to rebuild repository metadata:
   ```bash
   ./update_repo.sh
   ```
3. Push changes to GitHub:
   ```bash
   ./push_to_github.sh
   ```
   *(Ensure GitHub Pages is set to deploy from the `/docs` directory on the `main` branch).*
