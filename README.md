BASH Fstab Generator
-----------------------------------
This is a small bash script that will generate a /etc/fstab file based on a YAML file

Note: The script as is only works with the three (3) first mountpoints being local volumes with no special options and the fourth and last mountpoint being an NFS mount with two (2) options. Any deviation from this format is considered non-conformant and requires a change to the script. It is assumed that at last update the entries are standard for a server running postgresql in the environment.


Usage: Place YAML file & utility.sh on the same server. Ensure the name and path to yaml file are correct in the script before running
Command: ./utility.sh
