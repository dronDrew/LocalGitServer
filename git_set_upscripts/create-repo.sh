#!/bin/bash

REPO_DIR="/home/git/repos"

echo "Enter new repository name:"
read REPO_NAME

# Basic validation
if [[ ! "$REPO_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
  echo "Invalid name. Use only letters, numbers, underscores, or dashes."
  exit 1
fi

FULL_PATH="$REPO_DIR/$REPO_NAME.git"

if [ -d "$FULL_PATH" ]; then
  echo "Repository already exists: $FULL_PATH"
  exit 1
fi

sudo -u git mkdir -p "$FULL_PATH"
sudo -u git git init --bare "$FULL_PATH"

echo "Repository created: $FULL_PATH"
echo "Remote URL: git@192.168.33.33:/home/git/repos/$REPO_NAME.git"