#!/usr/bin/env bash
set -e

# Target directory
INSTALL_DIR="$HOME/{DIRECTORY_PATH}"
GITHUB_REPO="{GIT_URL}"

# Clone or update
if [ -d "$INSTALL_DIR" ]; then
  echo "Updating existing installation in $INSTALL_DIR"
  git -C "$INSTALL_DIR" pull
else
  echo "Cloning repository into $INSTALL_DIR"
  git clone {GITHUB_REPO} "$INSTALL_DIR"
fi

# Add to PATH in .zshrc if not already present
if ! grep -q '${INSTALL_DIR}/bin' "$HOME/.zshrc"; then
  echo 'export PATH="$HOME/{DIRECTORY_PATH}/bin:$PATH"' >> "$HOME/.zshrc"
  echo "Added to ~/.zshrc. Run 'source ~/.zshrc' or restart your shell."
fi

# chmod +x install.sh
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/your-username/my-shell-scripts/main/install.sh)"
