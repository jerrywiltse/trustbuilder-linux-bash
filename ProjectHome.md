Trustbuilder is a simple bash script that runs on one host, and automates the very common and tedious process of exchanging encryption keys with another host. This is often done for linux and unix servers to allow scripts to login to a remote servers using ssh authentication, without requiring a user to enter a password.  I.E., this sets up unattended server-to-server authentication for you. There is no error handling in this script, and this type of key exchange may be considered an insecure practice by some institutions.  Use at your own risk.

The manual process is documented here (as well as countless other places).

http://www.wonderland.com/~dracon/buildstuff/unattended_ssh.html

Here are the usage instructions:

---

  1. When running the script, you MUST provide two arguments:
    1. Remote Post (ip or hostname)
    1. Remote Port (tcp port)
  1. Here is an example of the command to execute this script:
    * `./trustbuilder.sh remoteserver.mydomain.com 22`
  1. The script will ask you for the remote server's password twice
  1. When complete, the identify files will be in the following format:
    * "tbldr-hostname-key"
  1. Here is an example of a scripted SSH command after the script is finished:
    * `ssh -i /root/.ssh/tbldr-hostname-key remoteserver.mydomain.com "uptime | awk '{print "Uptime="$1}';df -h | awk '/hda1/ {print "DiskUsage="$5}'"`