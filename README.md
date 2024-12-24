# Hydra Nmap Brute Force Script

This Bash script automates the process of identifying active hosts on a network using Nmap and performing a brute force attack on a specified service using Hydra. It simplifies the workflow for penetration testing by combining network scanning and authentication brute-forcing in a single script.

## Features

- **Nmap Scan**: Identifies open ports for a specified service on a network.
- **Hydra Brute Force**: Performs brute force attacks on the specified service using Hydra with provided credentials.
- **Automated Workflow**: Combines scanning and brute forcing, outputting actionable results.

## Prerequisites

- **Nmap**: Ensure Nmap is installed. Install it with:
  
  ```bash
  sudo apt install nmap
  ```

- **Hydra**: Ensure Hydra is installed. Install it with:
  
  ```bash
  sudo apt install hydra
  ```

- **Bash Shell**: Compatible with Unix-like systems (Linux, macOS).

- **Root/Administrator Privileges**: Requires elevated permissions to perform SYN scans and brute force attacks.

## Usage

Run the script with the following arguments:

```bash
sudo ./hydra-nmap-brute.sh <user> <password> <port> <cidr_network_address> <service>
```

### Arguments

- **user**: The username to use for the brute force attack.
- **password**: The password to use for the brute force attack.
- **port**: The port number of the target service.
- **cidr_network_address**: The target network in CIDR notation (e.g., `192.168.1.0/24`).
- **service**: The service to target (e.g., `ftp`, `ssh`, `http`).

### Example

```bash
sudo ./hydra-nmap-brute.sh admin password123 22 192.168.1.0/24 ssh
```

This example scans the `192.168.1.0/24` network for hosts with port `22` open and uses Hydra to perform a brute force attack on the SSH service with the provided credentials (`admin` and `password123`).

## How It Works

1. **Nmap Scan**: Scans the network for open ports on the specified service:
   
   ```bash
   nmap --open -sS -g 53 -p <port> -Pn <network> -oG nmap_out
   ```
   
2. **Filter Hosts**: Extracts the IP addresses of hosts with the specified port open:
   
   ```bash
   cat nmap_out | grep "Up" | cut -d " " -f 2 > hosts
   ```

3. **Hydra Brute Force**: Runs Hydra to perform a brute force attack on the specified service using the provided credentials:
   
   ```bash
   hydra -s <port> -l <user> -p <password> -M hosts <service>
   ```


## Notes

- **Permissions**: Ensure you run the script with `sudo` or root privileges for proper operation.
- **Ethical Use**: Only use this script on networks and services you are authorized to test.
- **Service-Specific Options**: Hydra supports many services (e.g., FTP, SSH, HTTP). Use the correct service identifier for accurate results.

## Author

Written by tyto.
