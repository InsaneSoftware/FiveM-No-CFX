# No-CFX FiveM Server Setup

A standalone FiveM server configuration that runs independently from the CFX/Cfx.re infrastructure.

## Overview

This server setup allows you to run a FiveM server without connecting to the CFX master list or requiring CFX licensing infrastructure. Players can connect directly via IP address.

## Features

### ✅ Advantages

- **No CFX License Key Required** - Run without needing a CFX license key
- **No Player Cap Restrictions** - Configure up to 2048 players (hardware permitting)
- **No Script License Checks** - Bypass CFX script verification systems
- **Ban-Proof** - Cannot be banned via CFX key system
- **No Lore-Friendly Requirements** - Complete creative freedom

### ⚠️ Limitations

- **Not Listed on Master List** - Server will not appear in the FiveM server browser
- **Hosting Vulnerabilities** - Server can still be taken down on non-bulletproof hosting providers
- **Manual Connection Required** - Players must connect via direct IP initially

## Server Configuration

### Network Settings
```
IP: 0.0.0.0:30120
Max Players: 2000
OneSync: Enabled
Game Build: 3570
```

### Server Details
- **Hostname:** Insanely FiveM Unlimited
- **Locale:** en-NL
- **Tags:** fun

## How to Start the Server

1. Ensure you have the following directory structure:
```
   ├── artifacts/
   │   ├── FXServer.exe
   │   └── citizen/
   └── server-data/
       ├── server.cfg
       └── resources/
```

2. Run `start.bat` to launch the server

3. The server will start on port `30120` (TCP/UDP)

## txAdmin Access

Use `startTX.bat` to launch with txAdmin enabled.


### Login Methods

- Username + Password

### Local Admin Credentials (Current Setup)

- **Username:** `Insane`
- **Password:** `glaswater`

If credentials fail, reset local admin state by removing `txData/default/admins.json`, restart `startTX.bat`, and complete setup with the PIN shown in console.

## Player Connection Guide

Since the server doesn't appear in the FiveM browser, players must connect manually:

### First-Time Connection

1. Open FiveM client
2. Press `F8` to open console
3. Type: `connect SERVERIP:30120`
4. Press Enter

**Example:** `connect 192.168.1.100:30120`

### After First Connection

- Server will appear in player's **History** tab
- Can be added to **Favorites** for easy access
- No need to type IP again

### Alternative Connection Methods

- Custom website with FiveM connect button:
```html
  <a href="fivem://connect/SERVERIP:30120">Join Server</a>
```
- Direct link: `fivem://connect/SERVERIP:30120`

## Security Recommendations

⚠️ **Important:** Since this server operates outside CFX infrastructure:

- Use **bulletproof hosting** or offshore providers
- Implement your own anti-cheat measures
- Regular backups are essential
- Consider DDoS protection services
- Monitor for abuse without CFX moderation tools

## Technical Notes

- OneSync is still functional
- Server enforces game build 3570
- Pure level set to 1 (basic file verification)
- ScriptHook is disabled for security

## Support & Disclaimer

This setup is for educational and testing purposes. Be aware of legal implications in your jurisdiction. The server operator is responsible for compliance with all applicable laws and regulations.

---

**Note:** While this configuration bypasses CFX infrastructure, you are still subject to Rockstar Games' terms of service and local laws regarding game server hosting.
