# FiveM No-CFX + Redirector Setup

This repository contains a dual-server setup:

1. **Main No-CFX server** (gameplay server)
2. **Redirector server** (browser-visible helper that tells players how to connect manually)

The main No-CFX server is not listed in the public FiveM browser, so the redirector exists to guide players into the main server.

## Why the Redirector Exists

- The No-CFX server does not appear in server list results.
- The redirector can appear in the list and provide join instructions.
- Players can then connect to the real server using manual connect.

WARNING: USE A FREE CFX ACCOUNT FOR THE REDIRECTOR (THEY CAN BAN THIS)
(ofcourse you can just create a new cfx account and put it up again)

This is optional! the NO CFX server always works without keys etc!

## Server Roles

### Main Server
- Config: `server-data/server.cfg`
- Start script: `start_No_CFX.bat`
- Purpose: actual gameplay

### Redirector Server
- Config: `server-data/server-redirect.cfg`
- Start script: `start_redirect_server.bat`
- Purpose: lightweight helper with `insane_redirect` resource only

## Start Order

1. Start main server:
   - `start_No_CFX.bat`
2. Start redirector:
   - `start_redirect_server.bat`

Both can run at the same time on different ports.

## Player Join Flow

1. Player finds **Insanely FiveM Redirector** in server list.
2. Player joins and sees manual connect instructions.
3. Player presses `F8` and runs:
   - `connect <MAIN_SERVER_IP_OR_DOMAIN>:30120`

Example:
`connect play.example.com:30120`

## Redirector Resource

- Resource name: `insane_redirect`
- Path: `server-data/resources/insane_redirect`
- Current behavior: pre-connect/manual instruction flow (no forced auto-jump)

## Server Icon Notes

Redirector icon is set with:

`load_server_icon myLogo.png`

Requirements:
- file must exist in `server-data/`
- PNG format
- 96x96 recommended

If icon still does not update in server list:
- restart redirector server
- rename icon file (example `myLogo2.png`) and update cfg
- wait for server-list cache refresh

## Headless / Portable Notes

- `server-redirect.cfg` has no hardcoded absolute `resourcesPath`.
- `start_redirect_server.bat` injects runtime paths.
- Redirector license key is loaded from:
  - `licence_key_for_redirect_server.txt`

## Security

- Do not commit real credentials or private keys.
- Keep `licence_key_for_redirect_server.txt` private.
