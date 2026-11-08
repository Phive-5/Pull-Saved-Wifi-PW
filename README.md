# Pull Saved Wi-Fi Passwords

A Windows PowerShell script that extracts all saved Wi-Fi profiles and their passwords (key content) from the local machine and writes them to a dated text file.

## Purpose

Quickly audit or recover the Wi-Fi passwords saved on a Windows PC. Useful when migrating to a new device or documenting your own network credentials. Runs entirely locally using the built-in `netsh` tool.

## Platform

- Windows only (PowerShell + `netsh wlan`)

## How It Works

1. Gets the current date and uses the script's own directory as the save location.
2. Runs `netsh wlan show profiles` to list every saved Wi-Fi profile.
3. For each profile, runs `netsh wlan show profile name="<profile>" key=clear` and extracts the `Key Content` (password).
4. Writes each profile name and its password (or "Not found or not set") to `calculator (yyyy-MM-dd).txt` in the script directory.
5. Prints the full path of the output file.

## Dependencies

- PowerShell (Windows)
- `netsh` (built into Windows)
- Administrator privileges may be required to reveal key content

## Usage

```powershell
# Run from PowerShell (ideally as Administrator)
.\calc.ps1
```

Output file: `calculator (yyyy-MM-dd).txt` in the same folder as the script.

## Files

- `calc.ps1` — the PowerShell script.
- `calc.exe` — compiled/bundled executable (if present).

## Notes

- Only retrieves passwords for networks already saved on this machine.
- Use responsibly and only on systems you own or are authorized to access. :)