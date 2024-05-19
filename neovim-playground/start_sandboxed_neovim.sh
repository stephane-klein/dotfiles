#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

export XDG_CONFIG_HOME=$PWD/config/
export XDG_DATA_HOME=$PWD/share/

nvim
