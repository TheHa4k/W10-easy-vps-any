# W10-easy-vps-any

Private helper project for reinstalling a compatible KVM VPS to **Windows 10 Pro** with a simple command.

## What it does

`setup.sh` downloads the open-source [`bin456789/reinstall`](https://github.com/bin456789/reinstall) installer and launches its Windows ISO install mode with:

- Windows 10 Pro
- English (`en-us`)
- RDP port `3389`
- Ping allowed

The upstream installer handles ISO retrieval, network setup, and supported VirtIO/public-cloud drivers.

## Important warning

**Running this installer erases the entire VPS disk.**

Use only on a VPS you own or administer, and only where your provider and Windows licensing terms permit the installation.

## Run after downloading `setup.sh`

```bash
chmod +x setup.sh
sudo ./setup.sh
```

## Private GitHub repository note

Because this repository is private, a normal anonymous command such as:

```bash
wget https://raw.githubusercontent.com/OWNER/W10-easy-vps-any/main/setup.sh
```

will not work without GitHub authentication.

For a private repository, either securely copy `setup.sh` to the VPS, or use an authenticated GitHub request. Do not place a long-lived GitHub token directly in a public script or README.

## RDP

After Windows installation completes, connect with Remote Desktop to:

```text
YOUR_VPS_IP:3389
```

Use the Windows username and password selected during installation.

## Credits

Installation engine: https://github.com/bin456789/reinstall
