#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

# Prepare identity arguments for age
identity_args=()
for key in ~/.ssh/id_*; do
    if [ -f "$key" ] && ! [[ "$key" == *.pub ]]; then
        identity_args+=("-i" "$key")
    fi
done

# Execute age with all identity files
age -d "${identity_args[@]}" -o .secret .secret.age

cat << EOF
Secret decrypted in .secret
Don't forget to run the command:

$ source .envrc
EOF
