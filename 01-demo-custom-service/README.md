# Demo: Custom service

This demo demonstrates how to create a custom systemd service unit which is then enabled and started on every boot. Moreover, the demo also shows how to modify a systemd service unit by adding a drop-in configuration file.

## Demo commands

```bash
# Push the blueprint to the composer
composer-cli blueprints push custom-service.toml
composer-cli blueprints show custom-service

# Build the image
composer-cli compose start custom-service qcow2

# Wait for the image to be built
composer-cli compose status | grep "<UUID>"

# Download the image
composer-cli compose image --filename image.qcow2 "<UUID>"
```

```bash
# Start a VM with the image
./../deploy-qemu image.qcow2
```

```bash
# SSH into the VM
ssh -p 2222 -o "StrictHostKeyChecking no" -o "UserKnownHostsFile=/dev/null" admin@localhost
```

```bash
# Check the service status
systemctl status custom.service
journalctl -u custom.service
```
