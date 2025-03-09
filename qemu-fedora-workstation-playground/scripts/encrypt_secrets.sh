#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

# Prepare recipient arguments for age
recipient_args=()
for pubkey in ./ssh-keys/*.pub; do
    if [ -f "$pubkey" ]; then
        recipient_args+=("-R" "$pubkey")
    fi
done

# Execute age with all public keys
age "${recipient_args[@]}" -o .secret.age .secret
