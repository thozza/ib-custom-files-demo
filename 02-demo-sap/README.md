# Demo: RHEL-9 image with SAP-specific configuration

This demo demonstrates how to create a RHEL image with SAP-specific configuration. The SAP configuration is based on what osbuild-composer RHEL SAP image. Note that the image package set won't match the official RHEL SAP image, because there is no other way to exclude packages from the image base package set, than to delete them on the first boot.

## Demo commands

```bash
# Push the blueprint to the composer
composer-cli blueprints push sap.toml
composer-cli blueprints show sap

# Add a custom source with SAP-specific packages
composer-cli sources add rhel-sap-repo.toml
composer-cli sources info rhel-sap-solutions

# Build the image
composer-cli compose start sap qcow2

# Wait for the image to be built
composer-cli compose status | grep "<UUID>"

# Download the image
composer-cli compose image --filename image.qcow2 "<UUID>"
```

```bash
# Start a VM with the image
./../deploy-qemu --vm-ssh-port 2222 image.qcow2
```

```bash
# SSH into the VM
ssh -p 2222 -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" admin@localhost
```

```bash
cat /etc/selinux/config

cat /etc/kernel/cmdline

cat /etc/tmpfiles.d/sap.conf

cat /etc/security/limits.d/99-sap.conf

cat /etc/sysctl.d/sap.conf

cat /etc/dnf/vars/releasever

cat /etc/sysconfig/network-scripts/ifcfg-eth0

tuned-adm active

rpm -q firewalld
```
