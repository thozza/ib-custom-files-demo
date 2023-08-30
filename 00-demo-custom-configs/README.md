# Demo: Custom configs

This demo demonstrates how to customize a RHEL image by adding custom configuration files. The demo configures the `sshd` service to listen on port 2222.

## Demo commands

```bash
# Push the blueprint to the composer
composer-cli blueprints push custom-configs.toml
composer-cli blueprints show custom-configs

# Build the image
composer-cli compose start custom-configs qcow2

# Wait for the image to be built
composer-cli compose status | grep "<UUID>"

# Download the image
composer-cli compose image --filename image.qcow2 "<UUID>"
```

```bash
# Start a VM with the image
# !!! Note the port on the VM is 2222, not 22 !!!
./../deploy-qemu --vm-ssh-port 2222 image.qcow2
```

```bash
# SSH into the VM
ssh -p 2222 -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" admin@localhost
```

```bash
# Demo commands
cat /etc/selinux/config
```
