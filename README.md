# Wi-Fi-Password-Retriever-and-Uploader-Script

This script retrieves Wi-Fi profiles from your Windows machine, extracts the associated passwords, and uploads them to a remote Apache server.

## Features:
- Retrieves all Wi-Fi profiles saved on the system.
- Extracts the passwords for each profile (if available).
- Sends the Wi-Fi profile names and passwords to an Apache server.

## How It Works:
1. The script retrieves all Wi-Fi profiles using the `netsh wlan show profiles` command.
2. It loops through each profile, extracting the password (if available) with the `netsh wlan show profile name=<SSID> key-clear` command.
3. The profiles and passwords are stored in a temporary file (`wifi_passwords.txt`).
4. The file is uploaded to the Apache server via a `POST` request using `curl`.
5. Temporary files are deleted, and the script terminates.

## Important Notes:
- **Security:** Be cautious when running this script as it will upload sensitive data.
