# This script will be executed on the first boot of the instance
#!/bin/bash

set -x

if [ $# -ne 3 ]; then
    echo "Usage: $0 <repo_url> <branch> <playbook>"
    exit 1
fi

REPO_URL=$1
BRANCH=$2
PLAYBOOK=$3

TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

git clone --branch "$BRANCH" "$REPO_URL" "$TMP_DIR"
cd "$TMP_DIR" || exit 1

if [ -f roles/requirements.yml ]; then
  ansible-galaxy role install -r roles/requirements.yml -p roles
fi

if [ -f collections/requirements.yml ]; then
  ansible-galaxy collection install -r collections/requirements.yml -p collections
fi

ansible-playbook -c local -i localhost, "$PLAYBOOK"
