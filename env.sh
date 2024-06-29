#!/bin/sh

# Set path to the current working directory
PROJECT_PATH="$PWD"

# Check if the shell is bash or zsh
if [ $SHELL = "/bin/bash" ]; then
  SHELL_RC="$HOME/.bashrc"
elif [ $SHELL = "/bin/zsh" ]; then
  SHELL_RC="$HOME/.zshrc"
else
  echo "Unsupported shell. Please use bash or zsh."
  exit 1
fi

# Check if entry exist and add it
if ! grep -q "export VBCC=\"$PROJECT_PATH/vbcc\"" "$SHELL_RC"; then
  echo "export VBCC=\"$PROJECT_PATH/vbcc\"" >> "$SHELL_RC"
  echo "Added VBCC environment variable to $SHELL_RC"
fi

if ! grep -q "export PATH=\"\$VBCC/bin:\$PATH\"" "$SHELL_RC"; then
  echo "export PATH=\"\$VBCC/bin:\$PATH\"" >> "$SHELL_RC"
  echo "Added VBCC/bin to PATH in $SHELL_RC"
fi

echo "Environment configuration completed."