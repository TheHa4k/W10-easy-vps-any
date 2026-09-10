#!/usr/bin/env bash
set -Eeuo pipefail

# W10-easy-vps-any
# Simple Windows 10 Pro VPS reinstall launcher.
# Uses the open-source bin456789/reinstall project.
#
# WARNING: THIS ERASES THE VPS DISK.

UPSTREAM_URL="https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh"
WORKDIR="/root/w10-easy-vps-any"
UPSTREAM_SCRIPT="$WORKDIR/reinstall.sh"

if [ "$(id -u)" -ne 0 ]; then
  echo "ERROR: Run as root."
  echo "Example: sudo bash setup.sh"
  exit 1
fi

echo
echo "========================================"
echo "          W10 Easy VPS Installer"
echo "========================================"
echo
echo "Target OS : Windows 10 Pro"
echo "Language  : English (en-us)"
echo "RDP port  : 3389"
echo
echo "WARNING: ALL DATA ON THIS VPS WILL BE ERASED."
echo

read -r -p 'Type INSTALL WINDOWS 10 to continue: ' CONFIRM
if [ "$CONFIRM" != "INSTALL WINDOWS 10" ]; then
  echo "Cancelled. Nothing was changed."
  exit 0
fi

mkdir -p "$WORKDIR"

echo
echo "[1/3] Downloading upstream installer..."
if command -v curl >/dev/null 2>&1; then
  curl -fL --retry 3 --connect-timeout 20 "$UPSTREAM_URL" -o "$UPSTREAM_SCRIPT"
elif command -v wget >/dev/null 2>&1; then
  wget -O "$UPSTREAM_SCRIPT" "$UPSTREAM_URL"
else
  apt-get update
  apt-get install -y curl
  curl -fL --retry 3 --connect-timeout 20 "$UPSTREAM_URL" -o "$UPSTREAM_SCRIPT"
fi

chmod 700 "$UPSTREAM_SCRIPT"

echo
echo "[2/3] Download complete."
sha256sum "$UPSTREAM_SCRIPT" 2>/dev/null || true

echo
echo "[3/3] Starting Windows 10 Pro setup..."
echo "You will be asked for the Windows username/password."
echo "Save that password for RDP."
echo
sleep 2

exec bash "$UPSTREAM_SCRIPT" windows \
  --image-name "Windows 10 Pro" \
  --lang en-us \
  --rdp-port 3389 \
  --allow-ping
