# Demo: execute a remote Ansible playbook on first boot (via script)

This demo demonstrates how to execute a remote Ansible playbook on first boot, by executing custom script embedded into the image.

The custom first boot service executes the script which runs the playbook from https://github.com/thozza/ib-custom-files-demo/tree/ansible-play.

The script is stored in /root directory, which is possible only since RHEL 8.9 / 9.3 os with c8s / c9s.

The script pulls the playbook from a remote git repository into a temporary directory. Installs any dependent Ansible roles and collections. Then it runs the playbook locally. As the last step, the temporary directory with the checked out playbook is removed.

The script expects ansible-core package to be installed on the system.

## Demo commands

```bash
# Push the blueprint to the composer
composer-cli blueprints push first-boot-script-ansible-playbook.toml
composer-cli blueprints show first-boot-script-ansible-playbook

# Build the image
composer-cli compose start first-boot-script-ansible-playbook qcow2

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
cat /var/log/first-boot-script.log

# Check the user created by the playbook
id demo2

# Check the timezone, which was set by the playbook
timedatectl status

# Check that the dnf-automatic has been set up by the playbook
systemctl status dnf-automatic-install.timer
cat /etc/dnf/automatic.conf
```
