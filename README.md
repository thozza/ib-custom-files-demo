# Demos of files and directories customization in Image Builder

This repository contains various demos of files and directories customization use cases in Image Builder.

For now, files and directories customizations are supported only on-premise. Missing functionality is tracked in the following issues:

- Support in the Service - https://issues.redhat.com/browse/HMS-1398
- Support in the cockpit-composer - https://issues.redhat.com/browse/COMPOSER-1909

## Prerequisites

Install and enable image builder on-premise.

```bash
sudo dnf install -y osbuild-composer osbuild-composer-cli

# On Fedora, one needs to configure the RHEL-9 repos to be able to build RHEL-9 images (officially not supported)
# Copy the RHEL-9 repo file from the upstream repository.
sudo mkdir -p /etc/osbuild-composer/repositories
sudo curl https://raw.githubusercontent.com/osbuild/osbuild-composer/main/repositories/rhel-9.json -o /etc/osbuild-composer/repositories/rhel-9.json

# start and enable osbuild-composer
sudo systemctl enable --now osbuild-composer.socket
```

## Demos

- [Custom configuration](00-demo-custom-configs/)
- [Custom service](01-demo-custom-service/)
- [Image with SAP-specific configuration](02-demo-sap/)
- [Execute a remote Ansible playbook on first boot (via ansible-pull)](03-demo-first-boot-ansible-pull/)
- [Execute a remote Ansible playbook on first boot (via script and ansible-playbook)](04-demo-first-boot-script-ansible-playbook/)

## Additional resources

- [Ondrej Budai's blog post about attaching additinal disk using custom first-boot service](https://budai.cz/posts/2023-07-18-first-boot-automation-in-image-builder/)
- [Files and directories customization documentation](https://www.osbuild.org/guides/image-builder-on-premises/blueprint-reference.html#files-and-directories)
