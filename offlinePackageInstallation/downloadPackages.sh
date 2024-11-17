#!/bin/bash

# Check if an argument (package list file) is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <package-list-file>"
  exit 1
fi

# Read packages from the specified file
if [ ! -f "$1" ]; then
  echo "Error: File $1 not found!"
  exit 1
fi

PACKAGES=$(cat "$1")

# Create a dated directory to store downloaded packages
DATEDIR=$(date +%d%m%Y)
mkdir -p "$DATEDIR"
cd "$DATEDIR" || exit 1

# Loop through the packages and download them with their dependencies
for pkg in $PACKAGES; do
  echo "Downloading $pkg..."
  apt-get download "$pkg" 2>>errors.txt

  # Download dependencies
  for i in $(apt-cache depends "$pkg" \
    | grep -E 'Depends|Recommends|Suggests' \
    | cut -d ':' -f 2,3 \
    | sed -e s/'<'/''/ -e s/'>'/''/); do
    echo "  Downloading dependency: $i"
    apt-get download "$i" 2>>errors.txt
  done
done

echo "Download complete. Errors (if any) are logged in errors.txt."
