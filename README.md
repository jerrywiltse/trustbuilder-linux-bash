# trustbuilder-linux-bash
Automatically exported from code.google.com/p/trustbuilder-linux-bash

Trustbuilder - Linux - Bash - Automated Key Exchange for SSH

Trustbuilder is a simple bash script that runs on one host, and automates the very common and tedious process of exchanging encryption keys with another host. This is often done for linux and unix servers to allow scripts to login to a remote servers using ssh authentication, without requiring a user to enter a password. I.E., this sets up unattended server-to-server authentication for you. There is no error handling in this script, and this type of key exchange may be considered an insecure practice by some institutions. Use at your own risk.

Here are the usage instructions:

When running the script, you MUST provide two arguments:
* Remote Post (ip or hostname)
* Remote Port (tcp port)

Here is an example of the command to execute this script:
     ./trustbuilder.sh remoteserver.mydomain.com 22
The script will ask you for the remote server's password twice
When complete, the identify files will be in the following format:
    "tbldr-hostname-key"

Here is an example of a scripted SSH command after the script is finished:
    ssh -i /root/.ssh/tbldr-hostname-key remoteserver.mydomain.com "uptime | awk '{print "Uptime="$1}';df -h | awk '/hda1/ {print "DiskUsage="$5}'"
