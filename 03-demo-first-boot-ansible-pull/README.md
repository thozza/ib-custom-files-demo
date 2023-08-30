# Demo: execute a remote Ansible playbook on first boot (via ansible-pull)

This demo demonstrates how to execute a remote Ansible playbook on first boot, using ansible-pull.

The custom first boot service executes applies the playbook from https://github.com/thozza/ib-custom-files-demo/tree/ansible-play-with-deps.

Note that the git repository with the Ansible playbook must contain all dependencies, including roles and collections. ansible-pull is not able to install them.

## Demo commands

```bash
# Push the blueprint to the composer
composer-cli blueprints push first-boot-ansible-pull.toml
composer-cli blueprints show first-boot-ansible-pull

# Build the image
composer-cli compose start first-boot-ansible-pull qcow2

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
# Check the output of the ansible-playbook run
journalctl -u custom-first-boot.service

# Check the user created by the playbook
id demo2

# Check the timezone, which was set by the playbook
timedatectl status

# Check that the dnf-automatic has been set up by the playbook
systemctl status dnf-automatic-install.timer
cat /etc/dnf/automatic.conf
```
