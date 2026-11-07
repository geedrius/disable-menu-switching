#!/bin/bash

# build.sh
# Build, pack and install the Disable Menu Switching GNOME Shell extension.

# Abort on the first failing step so a broken build is never packed or installed
set -euo pipefail

# Run from the repository root regardless of where the script is called from
cd "$(dirname "$0")"

UUID=$(sed -n 's/.*"uuid": *"\([^"]*\)".*/\1/p' metadata.json)
PACKAGE="${UUID}.shell-extension.zip"

# extension.js and metadata.json are packed by default; list any additional
# source files here
SOURCES="
    "

function Help()
{
    echo "Usage: $(basename "$0") [-bil]"
    echo "  -b  build (pack) the extension into ${PACKAGE}"
    echo "  -i  install the packed extension"
    echo "  -l  log out of the GNOME session afterwards"
}

build=""
install=""
logout=""

while getopts ":bilh" option; do
    case $option in
    b)
        build=1;;
    i)
        install=1;;
    l)
        logout=1;;
    *)
        Help
        exit;;
    esac
done

if [[ -z $build && -z $install && -z $logout ]]; then
    Help
    exit
fi

if [[ $build ]]; then
    EXTRA_SOURCES=""
    for SCRIPT in ${SOURCES}; do
        EXTRA_SOURCES="${EXTRA_SOURCES} --extra-source=${SCRIPT}"
    done

    echo "Packing extension..."
    gnome-extensions pack --force $EXTRA_SOURCES .
fi

if [[ $install ]]; then
    if [[ ! -f $PACKAGE ]]; then
        echo "${PACKAGE} not found, build it first with -b" >&2
        exit 1
    fi

    echo "Installing extension..."
    gnome-extensions install --force "$PACKAGE"
fi

if [[ $logout ]]; then
    echo "Quitting GNOME session..."
    gnome-session-quit --logout --no-prompt
fi
