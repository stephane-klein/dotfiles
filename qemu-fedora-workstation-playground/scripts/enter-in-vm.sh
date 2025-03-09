#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

ssh-keygen -R "[localhost]:2222"
ssh -o StrictHostKeyChecking=no -p 2222 stephane@localhost
